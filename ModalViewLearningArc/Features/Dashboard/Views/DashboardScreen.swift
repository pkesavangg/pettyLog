//
//  DashboardScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

struct DashboardScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(CategoryAggregateModel.self) var categoryModel
    @Environment(TagAggregateModel.self) var tagModel
    @Environment(\.appTheme) private var theme

    @State private var selectedTab: DashboardTab = .entry

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .environment(HomeAggregateModel(authModel: authModel))
                    .tabItem {
                        Label(CommonStrings.home, systemImage: AppAssets.house)
                    }
                    .tag(DashboardTab.home)

                EntryScreen()
                    .environment(EntryAggregateModel(authModel: authModel, categoryModel: categoryModel, tagModel: tagModel))
                    .tabItem {
                        Label(CommonStrings.entry, systemImage: AppAssets.rectangle)
                    }
                    .tag(DashboardTab.entry)

                SettingsScreen()
                    .tabItem {
                        Label(CommonStrings.settings, systemImage: AppAssets.gear)
                    }
                    .tag(DashboardTab.settings)
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
        .environment(CategoryAggregateModel(authModel: AuthAggregateModel()))
        .environment(TagAggregateModel(authModel: AuthAggregateModel()))
        .environmentObject(ThemeManager.shared)
}


