//
//  Environment.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

let environment: Environment = .dev

enum Environment {
    case dev
    case prod
}

extension Environment {
    
    var baseURL: String {
        switch self {
        case .dev:
            return "https://dev.api.recime.app"
        case .prod:
            return ""
        }
    }
}


