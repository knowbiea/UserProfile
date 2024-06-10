//
//  DefaultUserListRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

final class DefaultUserListRepository {

    // MARK: - Properties
    private let dataTransferService: DataTransferService

    // MARK: - Initialisers
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultUserListRepository: UserListRepository {
    
    func fetchUserList() async throws -> UserList {
        let requestDTO = UserListRequestDTO(page: 1)
        let endpoint = APIUserListEndPoints.user.getUserList(with: requestDTO)
        return try await dataTransferService.request(with: endpoint).toDomain()
    }
}
