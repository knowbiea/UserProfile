//
//  UserDetailRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

protocol UserDetailRepository {
    func fetchUserDetail(userID: Int) async throws -> UserDetail
}
