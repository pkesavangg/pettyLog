//
//  ThemeScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//


import SwiftUI

struct ThemeScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.appTheme) var theme
    @Environment(AuthAggregateModel.self) var authAggregateModel
    let lang = ThemeScreenStrings.self
    
    var body: some View {
        VStack(spacing: 20) {
            List {
                HStack {
                    Text(lang.themeColor)
                        Spacer()
                    Picker("", selection: $themeManager.currentColorScheme) {
                        ForEach(AppColorScheme.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(height: 30)
                }
                
                HStack {
                    Text(lang.appearance)
                        Spacer()
                    Toggle("", isOn: $themeManager.isDarkMode)
                }
            }
            .foregroundColor(theme.onSurface)
        }
        .accentColor(theme.primary)
        .toolbar(.hidden, for: .tabBar)
        .scrollContentBackground(.hidden)
        .background(LinearGradient(colors: [theme.primary.opacity(0.2), .white], startPoint: .top, endPoint: .bottom))
        .navigationTitle(lang.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ThemeScreen()
        .environmentObject(ThemeManager.shared)
        .environment(AuthAggregateModel())
}
