//
//  RecipeDemoAppApp.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import SwiftUI

@main
struct RecipeDemoApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("UITEST_MODE") {
                RecipeListView()
                    .environment(\.colorScheme, .light)
            } else {
                RecipeListView()
            }
        }
    }
}
