//
//  UserList.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

struct UserList: Codable {
    let users: [User]?
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct User: Codable, Hashable {
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
