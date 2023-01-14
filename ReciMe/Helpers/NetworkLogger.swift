//
//  NetworkLogger.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

final class NetworkLogger {
    
    static func log(request: URLRequest) {
        Logger.log("=== CURL ===\n\(request.curlString)")
    }

    static func log(data: Data?, response: URLResponse?, error: Error?) {
        Logger.log("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { Logger.log("\n - - - - - - - - - - END - - - - - - - - - - \n") }

        var logOutput = ""

        if let error = error {
            logOutput += "ERROR: \(error)\n"
        }

        if let response = response as? HTTPURLResponse {
            logOutput += "RESPONSE STATUS CODE: \(response.statusCode)\n"
            logOutput += "RESPONSE HEADERS:\n"

            for (key, value) in response.allHeaderFields {
                logOutput += "\(key): \(value) \n"
            }

            logOutput += "\n"
        }

        if let data = data?.prettyPrintedJSONString {
            logOutput += "DATA: \(data)"
        }

        Logger.log(logOutput)
    }

    static func log(request: URLRequest, data: Data?, response: URLResponse?, error: Error?) {
        Logger.log("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { Logger.log("\n - - - - - - - - - - END - - - - - - - - - - \n") }

        var logOutput = ""

        if let error = error {
            logOutput += "ERROR: \(error)\n"
        }

        if let response = response as? HTTPURLResponse {
            logOutput += "REQUEST: \(response.url?.absoluteString ?? "")\n"
            logOutput += "RESPONSE STATUS CODE: \(response.statusCode)\n"
            logOutput += "RESPONSE HEADERS:\n"

            for (key, value) in response.allHeaderFields {
                logOutput += "\(key): \(value) \n"
            }

            logOutput += "\n"
        }

        if let data = data {
            logOutput += "DATA: \(data.prettyPrintedJSONString ?? "")"
        }

        Logger.log(logOutput)
    }
}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}

