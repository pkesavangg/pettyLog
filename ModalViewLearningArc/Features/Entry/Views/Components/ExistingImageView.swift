//
//  ExistingImageView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 27/04/25.
//

import SwiftUI

// MARK: - ExistingImageView
struct ExistingImageView: View {
    @Environment(\.appTheme) private var theme
    let imageURL: String
    let onDelete: () -> Void
    
    var body: some View {
        if let url = URL(string: imageURL) {
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
                
                Button(action: onDelete) {
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
