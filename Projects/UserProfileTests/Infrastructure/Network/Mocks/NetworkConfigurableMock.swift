//
//  NetworkConfigurableMock.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import Foundation
@testable import UserProfile

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
