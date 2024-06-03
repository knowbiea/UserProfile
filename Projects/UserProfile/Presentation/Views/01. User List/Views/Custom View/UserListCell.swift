//
//  UserListCell.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct UserListCell: View {
    
    // MARK: - Properties
    var user: User
    
    // MARK: - ContentView
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                VStack {
                    UserImageView(url: URL(string: user.image.value))
                    .frame(width: 70, height: 70)
                    .clipped()
                    .background(.white)
                    .cornerRadius(.infinity)
                    
                }
                .frame(width: 72, height: 72)
                .background(Color.black.opacity(0.3))
                .cornerRadius(.infinity)
                
                
                VStack(spacing: 4) {
                    Text("\(user.firstName.value) \(user.lastName.value)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.medium15)
                    Text(user.email.value)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.regular12)
                }
            }
            .padding(10)
            
            Divider()
                .background(.gray.opacity(0.2))
                .padding([.leading, .trailing], 12)
        }
        .background(.white)
    }
}

#Preview {
    ZStack {
        VStack(spacing: 0) {
            UserListCell(user: User(id: 1,
                                    firstName: "Firstname",
                                    lastName: "Lastname",
                                    email: "sample@gmail.com",
                                    phone: "+91 9988998899",
                                    username: "sample_username",
                                    birthDate: "01-01-1990",
                                    image: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg",
                                    role: "Executive"))
            
            UserListCell(user: User(id: 1,
                                    firstName: "Firstname",
                                    lastName: "Lastname",
                                    email: "sample@gmail.com",
                                    phone: "+91 9988998899",
                                    username: "sample_username",
                                    birthDate: "01-01-1990",
                                    image: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg1",
                                    role: "Executive"))
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.green)
}
