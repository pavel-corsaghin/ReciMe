//
//  RecipeEndpoint.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

enum RecipeEndpoint {
    case recipeList
}

extension RecipeEndpoint: Endpoint {
    private var basePath: String { "/web-api/profile" }

    var path: String {
        switch self {
        case .recipeList:
            return "\(basePath)/7NWpTwiUWQMm89GS3zJW7Is3Pej1/posts"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .recipeList:
            return .get
        }
    }

    var httpBody: Data? {
        switch self {
        case .recipeList:
            return nil
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .recipeList:
            return [:]
        }
    }

    var queryItems: [String : String]? {
        switch self {
        case .recipeList:
            return nil
        }
    }
}
