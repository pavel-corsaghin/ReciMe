//
//  Error.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

struct ErrorData: Equatable {
    let status: HttpStatus
    let message: String
}

enum NetworkError: Error, LocalizedError, Equatable {
    case errorWithMessage(_ message: String)
    case errorWithData(_ data: ErrorData)
}
