//
//  AppDIContainer.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

final class AppDIContainer {
    
    static var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: Configuration.environment.baseURL)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
    
    // MARK: - DIContainers
    func makeUserListDIContainer() -> UserListDIContainer {
        let dependencies = UserListDIContainer.Dependencies(apiDataTransferService: AppDIContainer.apiDataTransferService)
        return UserListDIContainer(dependencies: dependencies)
    }
}

