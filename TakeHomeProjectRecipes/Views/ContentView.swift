//
//  ContentView 2.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import SwiftUI

/// A view with tabs for different recipe endpoints.
struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            RecipesListView(viewModel: viewModel, title: "All Recipes", endpoint: .allRecipes)
                .tabItem {
                    Label("All Recipes", systemImage: "list.bullet")
                }
                .tag(0)

            RecipesListView(viewModel: viewModel, title: "Malformed Recipes", endpoint: .malformedRecipes)
                .tabItem {
                    Label("Malformed", systemImage: "exclamationmark.triangle")
                }
                .tag(1)

            RecipesListView(viewModel: viewModel, title: "Empty Recipes", endpoint: .emptyRecipes)
                .tabItem {
                    Label("Empty", systemImage: "tray")
                }
                .tag(2)
        }
    }
}
