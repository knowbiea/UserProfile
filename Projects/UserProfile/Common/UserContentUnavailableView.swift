//
//  UserContentUnavailableView.swift
//  UserProfile
//
//  Created by Arvind on 06/06/24.
//

import SwiftUI

struct UserContentUnavailableView: View {
    
    // MARK: - Properties
    var type: ContentUnavailableType
    var actionCompletion: (() -> ())?
    
    // MARK: - Content View
    var body: some View {
        VStack {
            ContentUnavailableView {
                Label(type.title, systemImage: type.systemImage)
            } description: {
                VStack(spacing: 10) {
                    Text(type.description)
                    
                    Button(action: {
                        actionCompletion?()
                        
                    }, label: {
                        Text(type.buttonTitle)
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
    UserContentUnavailableView(type: .userList)
}
