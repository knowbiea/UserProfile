//
//  UserListRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserListRepository {
    @discardableResult
    func fetchUserList(completion: @escaping (Result<UserList, Error>) -> Void) -> Cancellable?
    func fetchUserList() async throws -> UserList
}
