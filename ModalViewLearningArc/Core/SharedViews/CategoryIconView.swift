//
//  CategoryIconView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import SwiftUI

struct CategoryIconView: View {
    let iconName: String
    let displayColor: Color
    
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        Circle()
            .fill(displayColor.opacity(0.85))
            .frame(width: 30, height: 30)
            .overlay {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            }
    }
}


// MARK: - Preview
#Preview {    
    CategoryIconView(iconName: "star.fill", displayColor: .red)
        .environmentObject(ThemeManager.shared) // Provide the ThemeManager environment object
}

