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
    func fetchUserDetail(userID: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) -> Cancellable? {
        let requestDTO = UserDetailRequestDTO(userID: userID)
        let task = RepositoryTask()
        let endpoint = APIUserListEndPoints.user.getUserDetail(with: requestDTO)
        
        task.networkTask = dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let userResponse):
                completion(.success(userResponse.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    func fetchUserDetail(userID: Int) async throws -> UserDetail {
        let requestDTO = UserDetailRequestDTO(userID: userID)
        let endpoint = APIUserListEndPoints.user.getUserDetail(with: requestDTO)
        return try await dataTransferService.request(with: endpoint).toDomain()
    }
}
