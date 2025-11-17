//
//  MockSuccessRecipeService.swift
//  RecipeDemoAppTests
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation

@testable import RecipeDemoApp

struct MockSuccessRecipeService: RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        return [
            Recipe(
                uuid: "123",
                name: "Mock Dish",
                cuisine: "Indian",
                photo_url_large: nil,
                photo_url_small: nil,
                source_url: nil,
                youtube_url: nil
            )
        ]
    }
}

struct MockFailureRecipeService: RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        throw URLError(.badServerResponse)
    }
}
