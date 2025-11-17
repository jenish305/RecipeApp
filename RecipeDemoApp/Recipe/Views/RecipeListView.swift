//
//  RecipeListView.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                if viewModel.isLoading && viewModel.recipes.isEmpty {
                    ProgressView("Loading recipes…")
                        .font(.title2)
                }
                else if let error = viewModel.errorMessage, viewModel.recipes.isEmpty {
                    errorView(error)
                }
                else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.recipes, id: \.id) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeGridCard(recipe: recipe)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .task { await viewModel.loadRecipes() }
        }
    }

    @ViewBuilder
    private func errorView(_ error: String) -> some View {
        VStack(spacing: 12) {
            Text("Failed to load recipes")
                .font(.headline)
            
            Text(error)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            Button("Retry") {
                Task { await viewModel.loadRecipes() }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).stroke())
        }
        .padding()
    }
}

struct RecipeGridCard: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            // MARK: - Image + Gradient
            AsyncImage(url: URL(string: recipe.bestImageURLString ?? "")) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFill()
                case .failure(_):
                    Color.gray.opacity(0.3)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.white.opacity(0.8))
                        )
                default:
                    ProgressView()
                }
            }
            .frame(height: 180)
            .frame(maxWidth: .infinity)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.65)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))
            )
            
            // MARK: - Title + Headline
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(recipe.headline)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(2)
            }
            .padding(10)
        }
        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)
    }
}


