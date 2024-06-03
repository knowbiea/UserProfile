//
//  NetworkConfig.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ApiDataNetworkConfig: NetworkConfigurable {
    
    // MARK: - Properties
    var baseURL: URL
    var headers: [String : String]
    var queryParameters: [String : String]
    
    // MARK: - Intialisers
    init(baseURL: URL, 
         headers: [String: String] = [:],
         queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
