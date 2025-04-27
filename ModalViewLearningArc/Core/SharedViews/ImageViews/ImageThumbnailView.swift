//
//  ImageThumbnailView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct ImageThumbnailView: View {
    @Environment(\.appTheme) private var theme
    
    let imageURL: String
    let size: CGFloat
    let onTap: (() -> Void)?
    
    init(imageURL: String, size: CGFloat = 150, onTap: (() -> Void)? = nil) {
        self.imageURL = imageURL
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        if let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size, height: size)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .onTapGesture {
                            if let onTap = onTap {
                                onTap()
                            }
                        }
                case .failure:
                    Image(systemName: AppAssets.photoWithExclamationMark)
                        .foregroundColor(theme.error)
                        .frame(width: size, height: size)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: size, height: size)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image(systemName: AppAssets.photoWithExclamationMark)
                .foregroundColor(theme.error)
                .frame(width: size, height: size)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

#Preview {
    VStack {
        ImageThumbnailView(
            imageURL: "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg"
        )
        
        ImageThumbnailView(
            imageURL: "invalid-url"
        )
    }
}
