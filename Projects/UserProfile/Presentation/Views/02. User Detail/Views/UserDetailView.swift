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
        case .loaded: userDetailView(user: viewModel.user)
        case .error: contentUnavailableView
        }
    }
}

extension UserDetailView {
    @ViewBuilder
    func userDetailView(user: UserDetail?) -> some View {
        if let user {
            VStack(spacing: 0) {
                List {
                    HStack {
                        UserImageView(url: URL(string: user.image.value))
                            .frame(width: 102, height: 102)
                            .clipped()
                            .cornerRadius(30.0)
                        
                        VStack {
                            UserTitleView(placeholder: Constant.common.name,
                                          text: "\(user.firstName.value) \(user.lastName.value)")
                            UserTitleView(placeholder: Constant.common.role,
                                          text: user.role.value)
                        }
                    }
                    .background()
                    
                    Section("Details") {
                        VStack(spacing: 8) {
                            UserTitleView(placeholder: Constant.common.email,
                                          text: user.email.value)
                            UserTitleView(placeholder: Constant.common.gender,
                                          text: user.gender.value.capitalized)
                            UserTitleView(placeholder: Constant.common.phone,
                                          text: user.phone.value)
                            UserTitleView(placeholder: Constant.common.bloodGroup,
                                          text: user.bloodGroup.value)
                        }
                        .padding([.top, .bottom], 6)
                    }
                    
                    if let address = user.address {
                        Section("Address") {
                            VStack(spacing: 8) {
                                UserTitleView(placeholder: Constant.common.address,
                                              text: address.address.value)
                                UserTitleView(placeholder: Constant.common.city,
                                              text: address.city.value)
                                UserTitleView(placeholder: Constant.common.state,
                                              text: address.state.value)
                                UserTitleView(placeholder: Constant.common.stateCode,
                                              text: address.stateCode.value)
                                UserTitleView(placeholder: Constant.common.postalCode,
                                              text: address.postalCode.value)
                            }
                            .padding([.top, .bottom], 6)
                        }
                    }
                    
                    if let company = user.company {
                        Section("Company") {
                            VStack(spacing: 8) {
                                UserTitleView(placeholder: Constant.common.department,
                                              text: company.department.value)
                                UserTitleView(placeholder: Constant.common.departmentName,
                                              text: company.name.value)
                                UserTitleView(placeholder: Constant.common.departmentTitle,
                                              text: company.title.value)
                            }
                            .padding([.top, .bottom], 6)
                        }
                    }
                    
                    if let crypto = user.crypto {
                        Section("Crypto") {
                            VStack(spacing: 8) {
                                UserTitleView(placeholder: Constant.common.coin,
                                              text: crypto.coin.value)
                                UserTitleView(placeholder: Constant.common.network,
                                              text: crypto.network.value)
                            }
                            .padding([.top, .bottom], 6)
                        }
                    }
                }
                .listStyle(.grouped)
            }
        } else {
            EmptyView()
            
        }
    }
    
    var contentUnavailableView: some View {
        VStack {
            ContentUnavailableView {
                Label(viewModel.unavailableType.title, systemImage: viewModel.unavailableType.systemImage)
            } description: {
                VStack(spacing: 10) {
                    Text(viewModel.unavailableType.description)
                    
                    Button(action: {
                        viewModel.getUserDetail()
                        
                    }, label: {
                        Text(viewModel.unavailableType.buttonTitle)
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
    let userDetailRepository = DefaultUserDetailRepository(dataTransferService: AppDIContainer.apiDataTransferService)
    let userDetailUseCase = DefaultUserDetailUseCase(userDetailRepository: userDetailRepository)
    return UserDetailView(viewModel: DefaultUserDetailViewModel(userID: 1,
                                                         userDetailUseCase: userDetailUseCase))
}
