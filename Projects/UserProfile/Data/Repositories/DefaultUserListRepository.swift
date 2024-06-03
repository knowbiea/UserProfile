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
    func fetchUserList(completion: @escaping (Result<UserList, any Error>) -> Void) -> Cancellable? {
        let requestDTO = UserListRequestDTO(page: 1)
        let task = RepositoryTask()
        let endpoint = APIUserListEndPoints.user.getUserList(with: requestDTO)
        
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
    
    func fetchUserList() async throws -> UserList {
        let requestDTO = UserListRequestDTO(page: 1)
        let endpoint = APIUserListEndPoints.user.getUserList(with: requestDTO)
        return try await dataTransferService.request(with: endpoint).toDomain()
    }
}

final class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
