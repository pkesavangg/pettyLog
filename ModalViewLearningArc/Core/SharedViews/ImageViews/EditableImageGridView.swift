//
//  EditableImageGridView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct EditableImageGridView: View {
    @Environment(\.appTheme) private var theme
    
    let existingImageURLs: [String]
    let newImages: [Image]
    
    var onExistingImageDelete: ((String) -> Void)
    var onNewImageDelete: ((Int) -> Void)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                // Display existing images from URLs
                ForEach(existingImageURLs, id: \.self) { urlString in
                    if let url = URL(string: urlString) {
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 150, height: 150)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                case .failure:
                                    Image(systemName: AppAssets.photo)
                                        .font(.system(size: 40))
                                        .foregroundColor(theme.onSurface.opacity(0.3))
                                        .frame(width: 150, height: 150)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            Button(action: {
                                onExistingImageDelete(urlString)
                            }) {
                                Image(systemName: AppAssets.xmarkCircle)
                                    .foregroundColor(theme.primary.opacity(0.8))
                                    .background(Circle().fill(theme.primary.opacity(0.2)))
                                    .font(.system(size: 15))
                            }
                            .offset(x: 4, y: -4)
                            .padding(.top, 8)
                            .padding(.trailing, 4)
                        }
                        .padding(.trailing, 8)
                    }
                }
                
                // Display newly selected images
                ForEach(0..<newImages.count, id: \.self) { i in
                    ZStack(alignment: .topTrailing) {
                        newImages[i]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                            onNewImageDelete(i)
                        }) {
                            Image(systemName: AppAssets.xmarkCircle)
                                .foregroundColor(theme.primary.opacity(0.8))
                                .background(Circle().fill(theme.primary.opacity(0.2)))
                                .font(.system(size: 15))
                        }
                        .offset(x: 4, y: -4)
                        .padding(.top, 8)
                        .padding(.trailing, 4)
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
}

#Preview {
    EditableImageGridView(
        existingImageURLs: ["https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg"],
        newImages: [
            Image(systemName: "photo")
        ],
        onExistingImageDelete: { _ in },
        onNewImageDelete: { _ in }
    )
}
