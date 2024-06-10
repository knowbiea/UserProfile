//
//  SwiftUI.View+Ext.swift
//  UserProfileTests
//
//  Created by Arvind on 06/06/24.
//

import SwiftUI

extension SwiftUI.View {
    var toVC: UIViewController {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = UIScreen.main.bounds
        return hostingController
    }
}
