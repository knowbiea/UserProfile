//
//  AppFlowCoordinator.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

final class AppFlowCoordinator: ObservableObject {
    
    // MARK: - Properties
    @Published var path: NavigationPath
    private let appDIContainer: AppDIContainer

    // MARK: - Initialisers
    init(path: NavigationPath, appDIContainer: AppDIContainer) {
        self.path = path
        self.appDIContainer = appDIContainer
    }

    @ViewBuilder
    func start() -> some View {
        MainView(appDIContainer: appDIContainer)
    }
}

