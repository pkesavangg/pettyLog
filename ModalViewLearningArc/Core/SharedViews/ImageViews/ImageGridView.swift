//
//  ImageGridView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct ImageGridView: View {
    let imageURLs: [String]
    let onImageTap: ((String) -> Void)?
    
    init(imageURLs: [String], onImageTap: ((String) -> Void)? = nil) {
        self.imageURLs = imageURLs
        self.onImageTap = onImageTap
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(imageURLs, id: \.self) { imageURLString in
                    ImageThumbnailView(imageURL: imageURLString) {
                        if let onImageTap = onImageTap {
                            onImageTap(imageURLString)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
    }
}

#Preview {
    ImageGridView(
        imageURLs: [
            "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg",
            "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg"
        ],
        onImageTap: { url in
            print("Tapped image: \(url)")
        }
    )
}
