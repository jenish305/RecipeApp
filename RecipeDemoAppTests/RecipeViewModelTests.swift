//
//  RecipeDemoAppTests.swift
//  RecipeDemoAppTests
//
//  Created by Jenish  Mac  on 17/11/25.
//

import XCTest
@testable import RecipeDemoApp

@MainActor
final class RecipeViewModelTests: XCTestCase {

    func testLoadSuccess() async throws {
        let vm = RecipeViewModel(service: MockSuccessRecipeService())

        await vm.loadRecipes()

        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.recipes.count, 1)
        XCTAssertEqual(vm.recipes.first?.name, "Mock Dish")
    }

    func testLoadFailure() async throws {
        let vm = RecipeViewModel(service: MockFailureRecipeService())

        await vm.loadRecipes()

        XCTAssertFalse(vm.isLoading)
        XCTAssertEqual(vm.recipes.count, 0)
        XCTAssertNotNil(vm.errorMessage)
    }

    func testRefreshCallsLoad() async throws {
        let vm = RecipeViewModel(service: MockSuccessRecipeService())

        await vm.refresh()

        XCTAssertEqual(vm.recipes.count, 1)
    }
}
