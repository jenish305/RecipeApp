//
//  RecipeViewModel.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation
import Combine

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: RecipeServiceProtocol

    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }

    func loadRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            recipes = try await service.fetchRecipes()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func refresh() async { await loadRecipes() }
}
