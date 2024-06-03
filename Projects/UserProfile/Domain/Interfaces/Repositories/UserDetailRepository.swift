//
//  UserDetailRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserDetailRepository {
    @discardableResult
    func fetchUserDetail(userID: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) -> Cancellable?
    func fetchUserDetail(userID: Int) async throws -> UserDetail
}
