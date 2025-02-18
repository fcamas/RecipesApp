//
//  RecipeViewModel.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import SwiftUI

/// A viewModel to handles fetching and caching recipes.
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    private let cache = NSCache<NSString, UIImage>()
    private var allRecipesCache: [Recipe] = []
    
    // Disk cache directory
      private var diskCacheURL: URL = {
          let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
          return urls[0].appendingPathComponent("ImageCache")
      }()

    /// Fetch recipes from a given endpoint.
    func fetchRecipes(from endpoint: RecipeAPI) async {
        guard let url = endpoint.url else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL."
            }
            return
        }

        // Use cache if available.
        if endpoint == .allRecipes, !allRecipesCache.isEmpty {
            DispatchQueue.main.async {
                self.recipes = self.allRecipesCache
                self.errorMessage = nil
            }
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([String: [Recipe]].self, from: data)
            DispatchQueue.main.async {
                self.recipes = decodedResponse["recipes"] ?? []
                if endpoint == .allRecipes {
                    self.allRecipesCache = self.recipes
                }
                self.errorMessage = self.recipes.isEmpty ? "No recipes available." : nil
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
            }
        }
    }

    /// Load an image with memory and disk caching.
       func loadImage(from urlString: String) async -> UIImage? {
           // Check memory cache
           if let cachedImage = cache.object(forKey: urlString as NSString) {
               return cachedImage
           }

           // Check disk cache
           let fileURL = diskCacheURL.appendingPathComponent(urlString.md5)
           if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
               cache.setObject(image, forKey: urlString as NSString)
               return image
           }

           // Download image if not cached
           guard let url = URL(string: urlString) else { return nil }

           do {
               let (data, _) = try await URLSession.shared.data(from: url)
               if let image = UIImage(data: data) {
                   cache.setObject(image, forKey: urlString as NSString)
                   try? data.write(to: fileURL)
                   return image
               }
           } catch {
               print("Image loading failed: \(error.localizedDescription)")
           }
           return nil
       }
}
