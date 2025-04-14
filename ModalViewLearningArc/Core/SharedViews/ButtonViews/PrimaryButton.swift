//
//  PrimaryButton.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void

    @Environment(\.appTheme) private var theme

    var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            Group {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .background(theme.primary)
            .foregroundColor(theme.onPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isLoading)
    }
}


#Preview {
    PrimaryButton(title: "Submit", isLoading: false) {
        print("Button tapped")
    }
    .environmentObject(ThemeManager.shared)
}
