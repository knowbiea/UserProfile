//
//  Optionals+Ext.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

extension Optional where Wrapped == String {
    var value: String {
        switch self {
        case .some(let value): return value
        case .none: return ""
        }
    }
}

extension Optional where Wrapped == URL {
    var value: URL {
        switch self {
        case .some(let value): return value
        case .none: return URL(string: "")!
        }
    }
}
