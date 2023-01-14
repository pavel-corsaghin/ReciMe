//
//  Network.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation
import Combine

typealias RequestModifier = ((URLRequest) -> URLRequest)

final class Network {

    static let shared = Network()
    private init() {}
            
    private var urlSession: URLSession { URLSession.shared }
    
    func request<T: Decodable>(_ endpoint: Endpoint, requestModifier: @escaping RequestModifier = { $0 }) -> AnyPublisher<Result<T, NetworkError>, Never> {
        let request = endpoint.request
        return Just(request)
            .setFailureType(to: Error.self)
            .handleEvents(receiveOutput: { request in
                let modifiedRequest = requestModifier(request)
                NetworkLogger.log(request: modifiedRequest)
            })
            .flatMap { [self] in
                urlSession.erasedDataTaskPublisher(for: requestModifier($0))
            }
            .handleEvents(receiveOutput: { data, response in
                NetworkLogger.log(request: request, data: data, response: response, error: nil)
            }, receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    NetworkLogger.log(request: request, data: nil, response: nil, error: error)
                case .finished:
                    break
                }
            })
            .tryMap { data, response -> Data in
                guard let res = response as? HTTPURLResponse else {
                    throw NetworkError.errorWithMessage("Invalid response")
                }
                
                guard let statusCode = HttpStatus(rawValue: res.statusCode) else {
                    throw NetworkError.errorWithMessage("No http status code")
                }
                
                guard statusCode.isSuccess else {
                    // TODO: try to decode data to get error message
                    throw NetworkError.errorWithData(.init(status: statusCode, message: ""))
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .map(Result.success)
            .catch { error -> AnyPublisher<Result<T, NetworkError>, Never> in
                guard let networkError = error as? NetworkError else {
                    return .just(.failure(.errorWithMessage(error.localizedDescription)))
                }
                
                return .just(.failure(networkError))
            }
            .eraseToAnyPublisher()
    }
    
}
