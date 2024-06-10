//
//  ContentUnavailableType.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

enum ContentUnavailableType {
    
    case userList
    case userDetail
    
    var title: String {
        switch self {
        case .userList, .userDetail: return "Unavailable"
        }
    }
    
    var systemImage: String {
        switch self {
        case .userList, .userDetail: return "exclamationmark.triangle.fill"
        }
    }
    
    var description: String {
        switch self {
        case .userList: return "Unable to fetch the user lists"
        case .userDetail: return "Unable to fetch the user detail"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .userList, .userDetail: return "Retry"
        }
    }
}
