//
//  RecipeDetailView.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: - HERO IMAGE SECTION
                    ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: URL(string: recipe.photo_url_large ?? recipe.photo_url_small ?? "")) { phase in
                            switch phase {
                            case .success(let img):
                                img.resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: 360)
                                    .clipped()

                            case .failure(_):
                                Color.gray.opacity(0.3)
                                    .frame(width: UIScreen.main.bounds.width, height: 360)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.largeTitle)
                                            .foregroundColor(.white.opacity(0.7))
                                    )

                            default:
                                ProgressView()
                                    .frame(width: UIScreen.main.bounds.width, height: 360)
                            }
                        }

                        LinearGradient(
                            colors: [.clear, .black.opacity(0.65)],
                            startPoint: .center,
                            endPoint: .bottom
                        )

                        VStack(alignment: .leading, spacing: 6) {
                            Text(recipe.name ?? "Recipe")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            if let cuisine = recipe.cuisine {
                                Text(cuisine)
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.85))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 34)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()


                    // MARK: - DETAILS CARD
                    VStack(alignment: .leading, spacing: 16) {

                        Text(recipe.headline)
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text(recipe.fullDescription)
                            .foregroundColor(.secondary)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)

                        if let src = recipe.source_url, let url = URL(string: src) {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "link")
                                    Text("Open source recipe")
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemGray6))
                                )
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .padding(.top, -30)

                    Spacer().frame(height: 80)
                }
                .frame(maxWidth: .infinity)
            }

            // MARK: - YOUTUBE BUTTON
            if let youtube = recipe.youtube_url,
               let url = URL(string: youtube) {

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                    .font(.title3)
                                Text("Watch Video")
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeDetailView(recipe: .previewSample)
}


