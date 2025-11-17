//
//  Enviroment.swift
//  RecipeDemoApp
//
//  Created by Jenish  Mac  on 17/11/25.
//

import Foundation

enum APIEnvironment {
    case staging, production
}

struct ServerConfig {
    public static var releaseMode: APIEnvironment = .staging

    struct URLs {
        fileprivate static var baseURL: String {
            switch releaseMode {
            case .staging: return "https://d3jbb8n5wk0qxi.cloudfront.net/"
            case .production: return ""
            }
        }

        fileprivate struct Version {
            // Endpoint
            static var basePath = "recipes.json"
            static var base: String { Version.basePath }
        }

        static var base: String {
            URLs.baseURL + Version.base
        }
    }
}
