//
//  DashboardScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


import SwiftUI

struct DashboardScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(\.appTheme) private var theme

    var body: some View {
        VStack(spacing: 0) {
            ThemeSwitcher()
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity)
                .background(theme.surface)
                .foregroundColor(theme.onSurface)

            TabView {
                HomeScreen()
                    .environment(HomeAggregateModel(authModel: authModel))
                    .tabItem {
                        Label(CommonStrings.home, systemImage: AppAssets.house)
                    }

                EntryScreen()
                    .tabItem {
                        Label(CommonStrings.entry, systemImage:AppAssets.rectangle)
                    }

                SettingsScreen()
                    .tabItem {
                        Label(CommonStrings.settings, systemImage: AppAssets.gear)
                    }
            }
            .accentColor(theme.primary)
        }
        .background(theme.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardScreen()
        .environment(AuthAggregateModel())
        .environmentObject(ThemeManager.shared)
}

