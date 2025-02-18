//
//  RecipeAPI.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import SwiftUI

/// A API endpoints for fetching recipes.
enum RecipeAPI {
    private static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    
    case allRecipes
    case malformedRecipes
    case emptyRecipes

    /// URL for each API case.
    var url: URL? {
        switch self {
        case .allRecipes:
            return URL(string: RecipeAPI.baseURL + "recipes.json")
        case .malformedRecipes:
            return URL(string: RecipeAPI.baseURL + "recipes-malformed.json")
        case .emptyRecipes:
            return URL(string: RecipeAPI.baseURL + "recipes-empty.json")
        }
    }
}
