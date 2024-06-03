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
        case .loaded: userListView(users: viewModel.users)
        case .error: contentUnavailableView
        }
    }
}

extension UserListView {
    
    @ViewBuilder
    func userListView(users: [User]) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12, alignment: .leading), count: 1), spacing: 0) {
                ForEach(users, id: \.self) { user in
                    UserListCell(user: user)
                        .onTapGesture {
                            viewModel.goToUserDetailView(user: user)
                        }
                }
            }
        }
    }
    
    var contentUnavailableView: some View {
        VStack {
            ContentUnavailableView {
                Label(viewModel.unavailable.title, systemImage: viewModel.unavailable.systemImage)
            } description: {
                VStack(spacing: 10) {
                    Text(viewModel.unavailable.description)
                    
                    Button(action: {
                        viewModel.getUserList()
                        
                    }, label: {
                        Text(viewModel.unavailable.buttonTitle)
                            .padding([.leading, .trailing], 20)
                            .padding([.top, .bottom], 10)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(AvenirNext.bold.of(size: 14))
                            .cornerRadius(8.0)
                    })
                }
            }
        }
        .padding(.bottom, 100)
    }
}

#Preview {
    NavigationStack {
        UserListView(viewModel: DefaultUserListViewModel(userListUseCase: DefaultUserListUseCase(userRepository: DefaultUserListRepository(dataTransferService: AppDIContainer.apiDataTransferService))))
    }
}
