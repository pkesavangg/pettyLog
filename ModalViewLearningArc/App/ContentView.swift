//
//  ContentView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthAggregateModel.self) var authModel
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        Group {
            switch authModel.authState {
            case .loading:
                ProgressView()
            case .loggedIn:
                DashboardScreen()
            case .loggedOut:
                LoginScreen()
            }
        }
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .environment(CategoryAggregateModel(authModel: authModel))
        .environment(TagAggregateModel(authModel: authModel))
    }
}


#Preview {
    ContentView()
        .environment(AuthAggregateModel())
        .environmentObject(ThemeManager.shared)
}

import SwiftUI



struct PaddingTest: View {
    var body: some View {
        Text("Hello, World!")
            .font(.subLargeTitle)
            .padding([.top, .horizontal], .p16)
            .cornerRadius(.small)
    }
}
