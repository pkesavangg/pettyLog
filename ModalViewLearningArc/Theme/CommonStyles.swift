//
//  CommonStyles.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import Foundation
import SwiftUI

struct LabelStyleModifier: ViewModifier {
    @Environment(\.appTheme) private var theme

    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(theme.onSurface.opacity(0.6))
    }
}

struct FormLabelStyleModifier: ViewModifier {
    @Environment(\.appTheme) private var theme

    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(theme.onSurface.opacity(0.6))
    }
}


extension View {
    func labelStyle() -> some View {
        self.modifier(LabelStyleModifier())
    }
    
    func formLabelStyle() -> some View {
        self.modifier(FormLabelStyleModifier())
    }
}
