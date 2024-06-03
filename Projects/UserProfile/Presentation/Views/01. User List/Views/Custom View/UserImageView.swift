//
//  UserImage.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserImageView: View {
    
    // MARK: - Properties
    var url: URL?
    
    // MARK: - Content View
    var body: some View {
        WebImage(url: url) { image in
            switch image {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure(_):
                Image(.placeholder)
                    .resizable()
            }
        }
    }
}

#Preview {
    VStack {
        UserImageView(url: URL(string: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"))
            .frame(width: 100, height: 100)
            .background(.red.opacity(0.2))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.green)
}
