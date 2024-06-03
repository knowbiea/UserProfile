//
//  NetworkService.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancellable {
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

protocol NetworkService {
    typealias completionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request<T: Requestable>(_ endpoint: T) async throws -> (data: Data, response: URLResponse)
    func request(endpoint: Requestable,
                 completion: @escaping completionHandler) -> NetworkCancellable?
}

protocol NetworkSessionManager {
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest) async throws -> (data: Data, response: URLResponse)
    func request(_ request: URLRequest,
                 completion: @escaping completionHandler) -> NetworkCancellable
}

protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

// MARK: - Network Service Implementation
final class DefaultNetworkService {
    
    // MARK: - Properties
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkErrorLogger
    
    init(config: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
         logger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        
        self.config = config
        self.sessionManager = sessionManager
        self.logger = logger
    }
    
    private func request(urlRequest: URLRequest, completion: @escaping completionHandler) -> NetworkCancellable {
        let session = sessionManager.request(urlRequest) { data, response, error in
            let result: Result<Data?, NetworkError>
            
            defer {
                completion(result)
            }
            
            if let error {
                var networkError: NetworkError
                
                if let response = response as? HTTPURLResponse {
                    networkError = .error(statusCode: response.statusCode, data: data)
                } else {
                    networkError = self.resolve(error: error)
                }
                
                self.logger.log(error: networkError)
                result = .failure(networkError)
                
            } else {
                self.logger.log(responseData: data, response: response)
                result = .success(data)
            }
        }
        
        logger.log(request: urlRequest)
        return session
    }
    
    private func request(urlRequest: URLRequest) async throws -> (data: Data, response: URLResponse) {
        do {
            logger.log(request: urlRequest)
            
            let (data, response) = try await sessionManager.request(urlRequest)
            let httpResponse = asHttpURLResponse(response)
            try checkErrorStatusCode(data, httpResponse)
            self.logger.log(responseData: data, response: response)
            
            return (data, response)
        } catch {
            let networkError: NetworkError = self.resolve(error: error)
            self.logger.log(error: networkError)
            
            throw networkError
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
    private func checkErrorStatusCode(_ data: Data, _ response: HTTPURLResponse) throws {
        let statusCode = response.statusCode
        guard !(200..<300 ~= statusCode) else {
            return
        }
        
        guard !(400..<499 ~= statusCode) else {
            throw NetworkError.error(statusCode: statusCode, data: data)
        }
        
        throw NetworkError.error(statusCode: statusCode, data: "500 Internal Server Error".data(using: .utf8))
    }
    
    private func asHttpURLResponse(_ response: URLResponse) -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("HTTP request handles in wrong way")
        }

        return httpResponse
    }
}

extension DefaultNetworkService: NetworkService {
    func request<T>(_ endpoint: T) async throws -> (data: Data, response: URLResponse) where T : Requestable {
        let urlRequest = try endpoint.urlRequest(with: config)
        return try await request(urlRequest: urlRequest)
    }
    
    func request(endpoint: Requestable,
                 completion: @escaping completionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(urlRequest: urlRequest, completion: completion)
            
        } catch {
            completion(.failure(.urlGeneration))
            return nil
            
        }
    }
}

final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    func log(request: URLRequest) {
        let requestString = """
                             **** API Request Start ****
                             Url: \(request.url?.absoluteString ?? "")
                             Method: \(request.httpMethod ?? "")
                             **** API Request End ****
                             """
        DLog(requestString)
    }
    
    func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data, let urlResponse = response as? HTTPURLResponse else { return }
        do {
            let jsonString = String(data: data, encoding: .utf8) ?? ""
            
            let responseString = """
                                 **** API Response Start ****
                                 Url: \(urlResponse.url?.absoluteString ?? "")
                                 Status Code: \(urlResponse.statusCode)
                                 Response: \(jsonString)
                                 **** API Response End ****
                                 """
            DLog(responseString)
        }
    }
    
    func log(error: Error) {
        DLog("Error: ", error.localizedDescription)
    }
}

