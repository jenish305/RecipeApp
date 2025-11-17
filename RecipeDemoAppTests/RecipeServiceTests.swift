//
//  RecipeServiceTests.swift
//  RecipeDemoAppTests
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation

import XCTest
@testable import RecipeDemoApp

struct InvalidURLRecipeService: RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        throw RecipeServiceError.invalidURL
    }
}

final class RecipeServiceTests: XCTestCase {

    func testInvalidURL() async {
        let service = InvalidURLRecipeService()

        do {
            _ = try await service.fetchRecipes()
            XCTFail("Expected invalidURL error")
        } catch let error as RecipeServiceError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
