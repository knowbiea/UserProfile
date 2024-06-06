//
//  UserList+Stub.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
@testable import UserProfile

extension UserListDTO {
    static func stub(users: [UserDTO]? = [UserDTO.stub()],
                     total: Int? = 200,
                     skip: Int? = 0,
                     limit: Int? = 30) -> Self {
        return .init(users: users,
                     total: total,
                     skip: skip,
                     limit: limit)
    }
    
}

extension UserDTO {
    static func stub(id: Int? = 1,
                     firstName: String? = "Emily",
                     lastName: String? = "Johnson",
                     email: String? = "emily.johnson@x.dummyjson.com",
                     phone: String? = "+81 965-431-3024",
                     username: String? = "emilys",
                     birthDate: String? = "1996-5-30",
                     image: String? = "",
                     role: String? = "admin") -> Self {
        .init(id: id,
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone,
              username: username,
              birthDate: birthDate,
              image: image,
              role: role)
    }
}
