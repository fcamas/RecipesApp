//
//  RecipeCard.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//


import SwiftUI

/// A view that displays a single recipe with image and details.
struct RecipeCard: View {
    let recipe: Recipe
    @State private var image: UIImage? = nil

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Text(recipe.name)
                .font(.headline)
                .lineLimit(1)
                .padding(.top, 8)
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let youtubeURL = recipe.youtube_url, let url = URL(string: youtubeURL) {
                HStack {
                    Spacer()
                    Link(destination: url) {
                        Image(systemName: "play.rectangle.fill")
                            .foregroundColor(.red)
                            .imageScale(.large)
                    }
                    .padding(.trailing, 8)
                }
            }
        }
        .task {
            if let photoUrl = recipe.photo_url_small {
                image = await RecipeViewModel().loadImage(from: photoUrl)
            }
        }
    }
}
