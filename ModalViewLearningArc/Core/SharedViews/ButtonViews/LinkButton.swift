//
//  LinkButton.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import SwiftUI

struct LinkButton: View {
    let title: String
    let action: () -> Void
    var font: Font = .footnote

    @Environment(\.appTheme) private var theme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(theme.primary)
        }
    }
}

#Preview{
    LinkButton(title: "Link Button") {
        print("Button pressed")
    }
    .environmentObject(ThemeManager.shared)
}
