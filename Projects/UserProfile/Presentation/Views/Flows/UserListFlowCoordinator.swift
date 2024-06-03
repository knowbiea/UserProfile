//
//  UserListFlowCoordinator.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

enum UserListPage {
    case userList, userDetail(User)
}

final class UserListFlowCoordinator: Hashable {
    
    // MARK: - Properties
    @Binding var navigationPath: NavigationPath
    var dependencies: UserListFlowCoordinatorDependencies
    
    private var id: UUID
    private var page: UserListPage
    
    init(navigationPath: Binding<NavigationPath>,
         dependencies: UserListFlowCoordinatorDependencies,
         page: UserListPage) {
        self.id = UUID()
        self._navigationPath = navigationPath
        self.dependencies = dependencies
        self.page = page
    }
    
    static func == (lhs: UserListFlowCoordinator, rhs: UserListFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Views
    @ViewBuilder
    func start() -> some View {
        switch self.page {
            case .userList: loginView()
            case .userDetail(let user): userDetailView(user: user)
        }
    }
    
    private func loginView() -> some View {
        let actions = UserListViewActions(goToUserDetailScreen: goToUserDetailScreen)
        return UserListView(viewModel: self.dependencies.makeUserListViewModel(actions: actions))
    }
    
    func goToUserDetailScreen(user: User) {
        self.push(UserListFlowCoordinator(navigationPath: self.$navigationPath,
                                          dependencies: dependencies,
                                          page: .userDetail(user)))
    }
    
    private func userDetailView(user: User) -> some View {
        return UserDetailView(viewModel: self.dependencies.makeUserDetailViewModel(userID: user.id ?? 0))
    }

    func push<V>(_ value: V) where V : Hashable {
        navigationPath.append(value)
    }
}

protocol UserListFlowCoordinatorDependencies  {
    func makeUserListViewModel(actions: UserListViewActions) -> DefaultUserListViewModel
    func makeUserDetailViewModel(userID: Int) -> DefaultUserDetailViewModel
}

