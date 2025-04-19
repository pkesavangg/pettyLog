//
//  CategoryIconSelectionView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//


import SwiftUI

struct IconSelectionView: View {
    @Environment(\.appTheme) private var theme
    @Binding var selectedIcon: String

    private let icons = CategoryIconConstants.allIcons

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private func setDefaultValue() {
        if selectedIcon.isEmpty,
           let defaultIcon = icons.first?.iconName {
            selectedIcon = defaultIcon
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(icons.indices, id: \.self) { index in
                    VStack {
                        Image(systemName: icons[index].iconName)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(
                                icons[index].iconName == selectedIcon
                                ? theme.primary.opacity(0.5)
                                : Color.clear
                            )
                            .cornerRadius(30)
                        Text(icons[index].categoryName)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedIcon = icons[index].iconName
                        }
                    }
                    .onAppear(perform: setDefaultValue)
                }
            }
            .padding()
        }
        .frame(minHeight: 400)
        .cornerRadius(20)
    }
}



#Preview {
    IconSelectionView(selectedIcon: .constant("fork.knife"))
        .environmentObject(ThemeManager.shared)
}
