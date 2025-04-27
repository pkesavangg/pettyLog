//
//  EntryImageSectionView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct EntryImageSectionView: View {
    @Environment(\.appTheme) private var theme
    
    let imageURLs: [String]
    let showHeader: Bool
    let onImageTap: ((String) -> Void)?
    
    init(
        imageURLs: [String],
        showHeader: Bool = true,
        onImageTap: ((String) -> Void)? = nil
    ) {
        self.imageURLs = imageURLs
        self.showHeader = showHeader
        self.onImageTap = onImageTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showHeader {
                // Image count indicator
                HStack {
                    Image(systemName: AppAssets.photo)
                        .foregroundColor(theme.primary)
                    Text(imageURLs.isEmpty ? EntryScreenStrings.bills : "\(imageURLs.count) image(s) attached")
                        .font(.caption)
                        .foregroundColor(theme.onSurface.opacity(0.7))
                }
            }
            
            if !imageURLs.isEmpty {
                ImageGridView(imageURLs: imageURLs, onImageTap: onImageTap)
            } else {
                BillsPlaceholderView()
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Preview with images
        EntryImageSectionView(
            imageURLs: [
                "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg",
                "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg"
            ],
            onImageTap: { url in
                print("Tapped image: \(url)")
            }
        )
        
        // Preview without images
        EntryImageSectionView(
            imageURLs: [],
            onImageTap: { url in
                print("Tapped image: \(url)")
            }
        )
    }
    .padding()
}
