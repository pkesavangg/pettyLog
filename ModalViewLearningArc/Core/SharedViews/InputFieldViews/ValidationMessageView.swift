//
//  ValidationMessageView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import SwiftUI

struct ValidationMessageView: View {
    let message: String?
    let show: Bool

    @Environment(\.appTheme) private var theme

    var body: some View {
        VStack {
            if let message = message, show {
                Text(message)
                    .foregroundColor(theme.error)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(height: 15)
    }
}

#Preview {
    ValidationMessageView(message: "Email is required", show: true)
        .environmentObject(ThemeManager.shared)
}
