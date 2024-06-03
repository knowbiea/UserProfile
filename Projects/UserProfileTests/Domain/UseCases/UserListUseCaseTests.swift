//
//  UserListUseCaseTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class UserListUseCaseTests: XCTestCase {

    func testUserListUseCase_whenSuccessfullyFetchingUserList() {
        // given
        var userList: UserList?
        let userListRepositoryMock = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        _ = useCase.execute(completion: { result in
            if case let .success(list) = result {
                userList = list
            }
        })
        
        // then
        XCTAssertTrue(userList != nil)
    }
    
    func testUserListUseCase_whenSuccessfullyFetchingUserListWithEmptyUser() {
        // given
        var users: [User] = []
        let userListRepositoryMock = UserListRepositoryMock(userList: UserList(users: [], 
                                                                               total: 150,
                                                                               skip: 0,
                                                                               limit: 12))
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        _ = useCase.execute(completion: { result in
            if case let .success(list) = result {
                users = list.users ?? []
            }
        })
        
        // then
        XCTAssertTrue(users.isEmpty)
    }

    func testUserListUseCase_whenFailedFetchingUserList() {
        // given
        var userList: UserList?
        var failedError: Error?
        let userListRepositoryMock = UserListRepositoryMock(error: UserListRepositoryMockError.failedFetching)
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        _ = useCase.execute(completion: { result in
            switch result {
            case .success(let user): userList = user
            case .failure(let error): failedError = error
            }
        })
        
        // then
        XCTAssertTrue(userList == nil)
        XCTAssertNotNil(failedError)
    }
    
    // MARK: - Async Testing
    func testUserListUseCase_whenSuccessfullyFetchingUserListAsync() async {
        // given
        var userList: UserList?
        var failedError: Error?
        let userListRepositoryMock = UserListRepositoryMock(userList: UserListDTO.stub().toDomain())
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        do {
            userList = try await useCase.execute()
        } catch {
            failedError = error
        }
        
        // then
        XCTAssertNotNil(userList)
        XCTAssertNil(failedError)
    }
    
    func testUserListUseCase_whenSuccessfullyFetchingUserListWithEmptyUserAsync() async {
        // given
        var users: [User] = []
        var failedError: Error?
        let userListRepositoryMock = UserListRepositoryMock(userList: UserList(users: [],
                                                                               total: 150,
                                                                               skip: 0,
                                                                               limit: 12))
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        do {
            let userList = try await useCase.execute()
            users = userList.users ?? []
            
        } catch {
            failedError = error
        }
        
        // then
        XCTAssertTrue(users.isEmpty)
        XCTAssertNil(failedError)
    }
    
    func testUserListUseCase_whenFailedFetchingUserList() async {
        // given
        var userList: UserList?
        var failedError: Error?
        let userListRepositoryMock = UserListRepositoryMock(error: UserListRepositoryMockError.failedFetching)
        let useCase = DefaultUserListUseCase(userRepository: userListRepositoryMock)
        
        // when
        do {
            userList = try await useCase.execute()
            
        } catch {
            failedError = error
        }
        
        // then
        XCTAssertNil(userList)
        XCTAssertNotNil(failedError)
    }
}
