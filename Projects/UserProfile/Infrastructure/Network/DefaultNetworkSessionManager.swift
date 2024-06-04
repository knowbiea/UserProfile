//
//  DefaultNetworkSessionManager.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

final class DefaultNetworkSessionManager: NetworkSessionManager {
    
    func request(_ request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let urlSession = URLSession(configuration: config)
        return try await urlSession.data(for: request)
    }
}
