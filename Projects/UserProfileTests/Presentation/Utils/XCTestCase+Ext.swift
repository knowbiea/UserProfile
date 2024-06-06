//
//  XCTestCase+Ext.swift
//  UserProfileTests
//
//  Created by Arvind on 06/06/24.
//

import SwiftUI
import XCTest

extension XCTestCase {
    func getImageFromBundle(resource: String, withExtension: String) -> URL {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: resource, withExtension: withExtension) else {
            return URL(string: "")!
        }
        
        return path
    }
}
