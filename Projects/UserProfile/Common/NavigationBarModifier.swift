//
//  NavigationBarModifier.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    // MARK: - Properties
    var title: String?
    var isLoading = false
    
    // MARK: - Initialisers
    init(title: String?,
         isLoading: Bool = false) {
        
        self.title = title
        self.isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .navigationTitle(title ?? "")
                .toolbarRole(.editor)
            
            if isLoading {
                ZStack {
                    VStack {
                        ProgressView()
                            .tint(.color(.dandelion))
                            .scaleEffect(2)
                            .padding(26)
                    }
                    .background(.white)
                    .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.15))
                .ignoresSafeArea()
            }
        }
        .toolbarBackground(Color.color(.dandelion), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

extension View {
    func setNavigationBar(title: String?,
                          isLoading: Bool = false) -> some View {
        self.modifier(NavigationBarModifier(title: title,
                                            isLoading: isLoading))
    }
}
