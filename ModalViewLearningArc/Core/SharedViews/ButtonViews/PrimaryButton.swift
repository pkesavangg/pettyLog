//
//  PrimaryButton.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let disable: Bool = false

    @Environment(\.appTheme) private var theme

    var body: some View {
        Button(action: {
            action()
        }) {
            Group {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .padding()
            }
            .background(theme.primary)
            .foregroundColor(theme.onPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(disable)
    }
}


#Preview {
    PrimaryButton(title: "Submit") {
        print("Button tapped")
    }
    .environmentObject(ThemeManager.shared)
}
