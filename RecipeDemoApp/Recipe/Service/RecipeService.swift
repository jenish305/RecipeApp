//
//  RecipeService.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation

enum RecipeServiceError: Error {
    case invalidURL
    case invalidResponse
}

final class RecipeService: RecipeServiceProtocol {
    private var endpointURL: URL? {
        URL(string: ServerConfig.URLs.base)
    }

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = endpointURL else { throw RecipeServiceError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw RecipeServiceError.invalidResponse
        }

        let decoder = JSONDecoder()
        return try decoder.decode(RecipeResponse.self, from: data).recipes
    }
}

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}
