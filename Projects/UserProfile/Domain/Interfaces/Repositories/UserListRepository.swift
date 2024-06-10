//
//  UserListRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserListRepository {
    func fetchUserList() async throws -> UserList
}
