//
//  Log+Ext.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

func DLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}
