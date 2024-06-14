//
//  MainView.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appCoordinator: AppFlowCoordinator
    private let appDIContainer: AppDIContainer
    
    // MARK: - Initialisers
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    // MARK: - Content View
    var body: some View {
        Group {
            appDIContainer.makeUserListDIContainer()
                .makeUserListFlowCoordinator(navigationPath: $appCoordinator.path)
                .start()
        }
    }
}

#Preview {
    MainView(appDIContainer: AppDIContainer())
}
