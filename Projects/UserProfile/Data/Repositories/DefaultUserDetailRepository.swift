//
//  DefaultUserDetailRepository.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

final class DefaultUserDetailRepository {
    
    // MARK: - Properties
    private let dataTransferService: DataTransferService

    // MARK: - Initialisers
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultUserDetailRepository: UserDetailRepository {
    
    func fetchUserDetail(userID: Int) async throws -> UserDetail {
        let requestDTO = UserDetailRequestDTO(userID: userID)
        let endpoint = APIUserListEndPoints.user.getUserDetail(with: requestDTO)
        return try await dataTransferService.request(with: endpoint).toDomain()
    }
}
