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

struct ListScreenStyleModifier: ViewModifier {
    let title: String
    var tabBarHidden: Bool = true

    @Environment(\.appTheme) private var theme

    func body(content: Content) -> some View {
        content
            .accentColor(theme.primary)
            .modifier(HideTabBarModifier(hidden: tabBarHidden))
            .scrollContentBackground(.hidden)
            .background(
                LinearGradient(
                    colors: [theme.primary.opacity(0.2), .white],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// Helper modifier to conditionally hide tab bar
struct HideTabBarModifier: ViewModifier {
    var hidden: Bool

    func body(content: Content) -> some View {
        if hidden {
            content.toolbar(.hidden, for: .tabBar)
        } else {
            content
        }
    }
}


extension View {
    func labelStyle() -> some View {
        self.modifier(LabelStyleModifier())
    }
    
    func formLabelStyle() -> some View {
        self.modifier(FormLabelStyleModifier())
    }
    
    func listScreenStyle(title: String, tabBarHidden: Bool = true) -> some View {
        self.modifier(ListScreenStyleModifier(title: title, tabBarHidden: tabBarHidden))
    }
}
