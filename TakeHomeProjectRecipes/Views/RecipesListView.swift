//
//  RecipesListView.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import SwiftUI

/// A view that shows a list of recipes.
struct RecipesListView: View {
    @ObservedObject var viewModel: RecipeViewModel
    let title: String
    let endpoint: RecipeAPI

    var body: some View {
        NavigationView {
            ScrollView {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(title)
            .refreshable {
                await viewModel.fetchRecipes(from: endpoint)
            }
            .onAppear {
                Task {
                    await viewModel.fetchRecipes(from: endpoint)
                }
            }
        }
    }
}
