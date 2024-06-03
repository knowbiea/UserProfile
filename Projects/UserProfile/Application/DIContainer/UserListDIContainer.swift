//
//  UserListDIContainer.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

final class UserListDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Co-Ordinator
    func makeUserListFlowCoordinator(navigationPath: Binding<NavigationPath>) -> UserListFlowCoordinator {
        UserListFlowCoordinator(navigationPath: navigationPath, dependencies: self, page: .userList)
    }
}

extension UserListDIContainer: UserListFlowCoordinatorDependencies {
    
    // MARK: - View Model
    func makeUserListViewModel(actions: UserListViewActions) -> DefaultUserListViewModel {
        DefaultUserListViewModel(userListUseCase: makeUserListUseCase(), actions: actions)
    }
    
    func makeUserDetailViewModel(userID: Int) -> DefaultUserDetailViewModel {
        DefaultUserDetailViewModel(userID: userID, userDetailUseCase: makeUserDetailUseCase())
    }
    
    // MARK: - Use Case
    func makeUserListUseCase() -> UserListUseCase {
        DefaultUserListUseCase(userRepository: makeUserListRepository())
    }
    
    func makeUserDetailUseCase() -> UserDetailUseCase {
        DefaultUserDetailUseCase(userDetailRepository: makeUserDetailRepository())
    }
    
    // MARK: - Repositories
    func makeUserListRepository() -> UserListRepository {
        DefaultUserListRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeUserDetailRepository() -> UserDetailRepository {
        DefaultUserDetailRepository(dataTransferService: dependencies.apiDataTransferService)
    }
}

