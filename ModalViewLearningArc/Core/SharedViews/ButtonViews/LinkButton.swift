//
//  LinkButton.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import SwiftUI

struct LinkButton: View {
    let title: String
    let isDisabled: Bool
    let action: () -> Void
    var font: Font = .footnote

    @Environment(\.appTheme) private var theme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(theme.primary.opacity(isDisabled ? 0.35 : 1))
        }
        .disabled(isDisabled)
    }
}

#Preview{
    LinkButton(title: "Link Button", isDisabled: true) {
        print("Button pressed")
    }
    .environmentObject(ThemeManager.shared)
}
