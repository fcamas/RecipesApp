//
//  Recipe.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import Foundation

/// A model representing a recipe.
struct Recipe: Identifiable, Codable {
    var id: String { uuid }
    let cuisine: String
    let name: String
    let photo_url_small: String?
    let photo_url_large: String?
    let uuid: String
    let source_url: String?
    let youtube_url: String?
}
