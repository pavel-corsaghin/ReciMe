//
//  AnyPublisher+Extensions.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation
import Combine

extension AnyPublisher {
    static func just(_ output: Output) -> Self {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func fail(with error: Failure) -> Self {
        Fail(error: error).eraseToAnyPublisher()
    }
}
