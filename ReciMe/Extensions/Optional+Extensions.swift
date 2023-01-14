//
//  Optional+Extensions.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

// MARK: - Optional with default value

extension Optional {

    // Build time optimization
    // by avoiding the nil coalescing operator by unwrapping things by hand with if let.
    // See: https://www.hackingwithswift.com/articles/11/how-to-make-swift-compile-faster
    func or(_ value: Wrapped?) -> Optional {
        guard let unwrappedSelf = self else { return value }
        return unwrappedSelf
    }

    func or(_ value: Wrapped) -> Wrapped {
        guard let unwrappedSelf = self else { return value }
        return unwrappedSelf
    }
}

// MARK: - Optional + Error

extension Optional {

    // Ref: https://www.swiftbysundell.com/articles/extending-optionals-in-swift/
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else { throw errorExpression() }
        return value
    }
}

extension Optional where Wrapped: RangeReplaceableCollection {

    var orEmpty: Wrapped {
        guard let value = self else { return Wrapped() }
        return value
    }

    func replaceEmptyWithNil() -> Wrapped? {
        guard self.orEmpty.isEmpty else { return self }
        return nil
    }
}

extension Optional where Wrapped: Collection {

    var isNilOrEmpty: Bool {
        flatMap { $0.isEmpty }.or(true)
    }
}
