//
//  Endpoint.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String, Codable, CaseIterable {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
}

protocol Endpoint {

    /// The path of the endpoint
    var path: String { get }

    /// The HTTP method of the endpoint
    var httpMethod: HTTPMethod { get }

    /// The HTTP Body of the endpoint
    var httpBody: Data? { get }

    // The headers of the endpoint
    var headers: HTTPHeaders { get }

    // The query params of the endpoint
    var queryItems: [String: String]? { get }
}

extension Endpoint {
    
    var request: URLRequest {
        guard let url = URL(string: environment.baseURL) else { fatalError("Invalid URL") }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Invalid URL")
        }
        
        components.path = path
        
        if let queryItems = queryItems?.compactMap({ URLQueryItem(name: $0.key, value: $0.value) }) {
            components.queryItems = queryItems
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        return request
    }
}
