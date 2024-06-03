//
//  UserTitleView.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

struct UserTitleView: View {
    
    // MARK: - Properties
    var placeholder: String
    var text: String
    
    // MARK: - Content View
    var body: some View {
        HStack(spacing: 4) {
            Text(placeholder)
                .font(.bold12)
            
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.regular12)
        }
    }
}

#Preview {
    UserTitleView(placeholder: "Name: ", text: "Emily")
}
