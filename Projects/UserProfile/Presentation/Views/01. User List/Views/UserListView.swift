//
//  UserListView.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct UserListView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: DefaultUserListViewModel
    
    // MARK: - Content View
    var body: some View {
        VStack {
            getBody(for: viewModel.viewState)
        }
        .onAppear {
            guard !viewModel.hasAppeared else { return }
            viewModel.hasAppeared.toggle()
            viewModel.getUserList()
        }
        .setNavigationBar(title: "Users", isLoading: viewModel.isLoading)
    }
    
    @ViewBuilder
    func getBody(for viewState: ViewState) -> some View {
        switch viewState {
        case .idle, .loading: EmptyView()
        case .loaded: UserListContentView(users: viewModel.users) { viewModel.goToUserDetailView(user: $0) }
        case .error: UserContentUnavailableView(type: viewModel.unavailableType) { viewModel.getUserList() }
        }
    }
}

#Preview {
    NavigationStack {
        UserListView(viewModel: DefaultUserListViewModel(userListUseCase: DefaultUserListUseCase(userRepository: DefaultUserListRepository(dataTransferService: AppDIContainer.apiDataTransferService))))
    }
}
