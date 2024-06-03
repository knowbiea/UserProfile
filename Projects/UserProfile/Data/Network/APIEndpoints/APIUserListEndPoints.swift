//
//  APIUserListEndPoints.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

struct APIUserListEndPoints {
    struct user {
        static func getUserList(with userListDTO: UserListRequestDTO) -> Endpoint<UserListDTO> {
            return Endpoint(path: "users",
                            method: .get,
                            queryParametersEncodable: userListDTO)
        }
        
        static func getUserDetail(with userDetailDTO: UserDetailRequestDTO) -> Endpoint<UserDetailDTO> {
            return Endpoint(path: "users/\(userDetailDTO.userID)",
                            method: .get)
        }
    }
}
