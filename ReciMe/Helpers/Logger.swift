//
//  Logger.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

private let showLog: Bool = {
    #if DEBUG
        return true
    #else
        return false
    #endif
}()

final class Logger {
    static func log(_ message: String) {
        guard showLog else {
            return
        }
        
        print(message)
    }
}
