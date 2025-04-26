//
//  BillsPlaceholderView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct BillsPlaceholderView: View {
    @Environment(\.appTheme) private var theme
    
    let message: String = EntryScreenStrings.billNotAttached
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 12) {
                Image(systemName: AppAssets.photo)
                    .font(.system(size: 40))
                    .foregroundColor(theme.onSurface.opacity(0.3))
                
                Text(message)
                    .font(.caption)
                    .foregroundColor(theme.onSurface.opacity(0.5))
            }
            .padding(.vertical, 30)
            Spacer()
        }
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding(.vertical, 8)
    }
}

#Preview {
    BillsPlaceholderView()
}
