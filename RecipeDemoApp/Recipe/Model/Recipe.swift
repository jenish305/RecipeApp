//
//  Recipe.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation


// MARK: - API Response + Model
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Identifiable, Codable, Hashable {

    // MARK: - Use server uuid as id, fallback to local UUID
    var id: String { uuid ?? localId }
    private let localId = UUID().uuidString

    let uuid: String?
    let name: String?
    let cuisine: String?
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?

    
    enum CodingKeys: String, CodingKey {
        case uuid, name, cuisine, photo_url_large, photo_url_small, source_url, youtube_url
    }
}

// MARK: - Generated fields for UI (headline & long description)
extension Recipe {
    // Short headline used in list cells
    var headline: String {
        let n = name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "This recipe"
        let c = (cuisine?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()).flatMap { $0.isEmpty ? nil : $0 } ?? "international"
        return "\(n) — a delicious \(c) dish loved for its flavour and simple preparation."
    }

    // Longer description used on detail screen
    var fullDescription: String {
        let n = name ?? "This recipe"
        let c = cuisine ?? "international"
        let linkLine = (source_url != nil && !source_url!.isEmpty) ? "\n\nFor full preparation steps, see the original source: \(source_url!)" : ""
        return """
        \(n) is a classic \(c.lowercased()) recipe known for its balanced flavours and approachable cooking steps. It pairs well with family meals and makes a great choice for both beginners and experienced cooks.

        This generated description is based on available  (name + cuisine).\(linkLine)
        """
    }

    /// Best image URL to use 
    var bestImageURLString: String? {
        if let small = photo_url_small, !small.isEmpty { return small }
        if let large = photo_url_large, !large.isEmpty { return large }
        return nil
    }
}

extension Recipe {
    static let previewSample = Recipe(
        uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        name: "Apam Balik",
        cuisine: "Malaysian",
        photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )
}
