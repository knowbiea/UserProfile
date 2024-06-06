//
//  UserImage.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
import Kingfisher

struct UserImageView: View {
    
    // MARK: - Properties
    var url: URL?
    var progressView = ProgressView()
    @State var isImageLoaded = false
    
    // MARK: - Content View
    var body: some View {
        ZStack {
            if !isImageLoaded {
                progressView
            }
            
            KFImage(url)
                .resizable()
                .placeholder {
                    if isImageLoaded {
                        Image(.placeholder)
                            .resizable()
                    }
                }
                .onSuccess { _ in
                    isImageLoaded = true
                }
                .onFailure { _ in
                    isImageLoaded = true
                }
        }
    }
}

#Preview {
    VStack {
        UserImageView(url: URL(string: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"))
            .frame(width: 300, height: 400)
            .background(.red.opacity(0.2))
            .clipped()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.green)
}
