//
//  UserDetailView.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct UserDetailView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: DefaultUserDetailViewModel
    
    // MARK: - ContentView
    var body: some View {
        ZStack {
            getBody(for: viewModel.viewState)
        }
        .onAppear {
            viewModel.getUserDetail()
        }
        .setNavigationBar(title: "User Detail", isLoading: viewModel.isLoading)
    }
    
    @ViewBuilder
    func getBody(for viewState: ViewState) -> some View {
        switch viewState {
        case .idle, .loading: EmptyView()
        case .loaded: UserDetailContentView(user: viewModel.user)
        case .error: UserContentUnavailableView(type: viewModel.unavailableType) { viewModel.getUserDetail() }
        }
    }
}

#Preview {
    let userDetailRepository = DefaultUserDetailRepository(dataTransferService: AppDIContainer.apiDataTransferService)
    let userDetailUseCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepository)
    return UserDetailView(viewModel: DefaultUserDetailViewModel(userID: 1,
                                                         userDetailUseCase: userDetailUseCase))
}
