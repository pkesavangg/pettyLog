//
//  ThemeSwitcher.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import SwiftUI

struct ThemeSwitcher: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Menu {
            Section {
                Button("Blue") { themeManager.currentColorScheme = .blue }
                Button("Red") { themeManager.currentColorScheme = .red }
                Button("Yellow") { themeManager.currentColorScheme = .yellow }
            }

            Divider()

            Button(themeManager.isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode") {
                themeManager.isDarkMode.toggle()
                print(themeManager.isDarkMode, "themeManager.isDarkMode")
            }
        } label: {
            Image(systemName: "paintpalette")
        }
    }
}
