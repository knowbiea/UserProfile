//
//  NetworkSessionManagerMock.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import Foundation
@testable import UserProfile

struct NetworkSessionManagerMock: NetworkSessionManager {
    
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        guard let data, let response else {
            throw error!
        }
        
        return (data, response as URLResponse)
    }
}
