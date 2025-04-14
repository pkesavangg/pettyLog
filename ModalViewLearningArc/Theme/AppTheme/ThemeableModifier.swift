//
//  AppThemeKey.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//

import SwiftUI

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppColors.Palette = AppColors.Theme.blue.palette
}

extension EnvironmentValues {
    var appTheme: AppColors.Palette {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

struct ThemeableModifier: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        let theme = themeFrom(themeManager.currentColorScheme)
        content.environment(\.appTheme, theme.palette)
    }

    private func themeFrom(_ scheme: ColorScheme) -> AppColors.Theme {
        switch scheme {
        case .blue: return .blue
        case .red: return .red
        case .yellow: return .yellow
        }
    }
}

extension View {
    func themeable() -> some View {
        modifier(ThemeableModifier())
    }
}
