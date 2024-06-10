//
//  UserListContentView.swift
//  UserProfile
//
//  Created by Arvind on 06/06/24.
//

import SwiftUI

struct UserListContentView: View {
    
    // MARK: - Properties
    var users: [User]
    var onTapCompletion: ((User) -> ())?
    
    // MARK: - Content View
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12, alignment: .leading), count: 1), spacing: 0) {
                ForEach(Array(users.enumerated()), id: \.element) { index, user in
                    UserListCell(user: user)
                        .onTapGesture {
                            onTapCompletion?(user)
                        }
                        .accessibilityIdentifier("UserItem_\(index)")
                }
            }
            .accessibilityIdentifier("userList_listGridView")
        }
    }
}

#Preview {
    UserListContentView(
        users: [User(id: 1,
                     firstName: "FirstName",
                     lastName: "LastName",
                     email: "sample@gmail.com",
                     phone: "+91 1122112211",
                     username: "username",
                     birthDate: "1990-12-31",
                     image: "",
                     role: "Admin")]
    )
}
