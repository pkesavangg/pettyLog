//
//  ThemeManager.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @Published var currentColorScheme: AppColorScheme {
        didSet {
            UserDefaults.standard.set(currentColorScheme.rawValue, forKey: "selectedThemeColor")
        }
    }

    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }

    private init() {
        let savedColor = UserDefaults.standard.string(forKey: "selectedThemeColor")
        currentColorScheme = AppColorScheme(rawValue: savedColor ?? "blue") ?? .blue

        isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}

