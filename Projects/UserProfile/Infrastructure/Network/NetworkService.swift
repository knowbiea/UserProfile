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
    func request<T: Requestable>(_ endpoint: T) async throws -> (data: Data, response: URLResponse)
}

protocol NetworkSessionManager {
    func request(_ request: URLRequest) async throws -> (data: Data, response: URLResponse)
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

