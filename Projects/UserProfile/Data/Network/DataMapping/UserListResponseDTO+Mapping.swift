//
//  UserListResponseDTO+Mapping.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

// MARK: - Data Transfer Object
struct UserListDTO: Codable {
    let users: [UserDTO]?
    let total: Int?
    let skip: Int?
    let limit: Int?
}

// MARK: - Mappings to Domain
extension UserListDTO {
    func toDomain() -> UserList {
        return .init(users: users?.map { $0.toDomain() },
                     total: total,
                     skip: skip,
                     limit: limit)
    }
}

// MARK: - Data Transfer Object
struct UserDTO: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let username: String?
    let birthDate: String?
    let image: String?
    let role: String?
}

// MARK: - Mappings to Domain
extension UserDTO {
    func toDomain() -> User {
        return .init(id: id,
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
