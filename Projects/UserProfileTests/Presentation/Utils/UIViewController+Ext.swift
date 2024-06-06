//
//  UIViewController+Ext.swift
//  UserProfileTests
//
//  Created by Arvind on 06/06/24.
//

import SwiftUI
import SnapshotTesting

extension UIViewController {
    func performSnapshotTest(named name: String,
                             testName: String = "Snapshot") {
        assertSnapshot(matching: self,
                       as: .image(precision: 0.9),
                       named: name,
                       testName: testName)
    }
}
