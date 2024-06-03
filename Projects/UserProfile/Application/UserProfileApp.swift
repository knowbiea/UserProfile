//
//  UserProfileApp.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

@main
struct UserProfileApp: App {
    
    // MARK: - Properties
    @StateObject private var appFlowCoordinator = AppFlowCoordinator(path: NavigationPath(),
                                                                 appDIContainer: AppDIContainer())
    
    // MARK: - Content View
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appFlowCoordinator.path) {
                appFlowCoordinator.start()
                    .navigationDestination(for: UserListFlowCoordinator.self) { coordinator in
                        coordinator.start()
                    }
            }
            .tint(.white)
            .environmentObject(appFlowCoordinator)
        }
    }
}
