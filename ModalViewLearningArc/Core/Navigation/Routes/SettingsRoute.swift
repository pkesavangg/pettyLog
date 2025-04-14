//
//  SettingsRoute.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//
import SwiftUI

enum SettingsRoute: Routable {
    case account, category
    
    var body: some View {
        switch self {
        case .account:
            AccountDetailView()
        case .category:
            CategoryView()
        }
    }
}

struct CategoryView: View {
    var body: some View {
        VStack {
            Text("Account Details")
                .font(.largeTitle)
                .padding()
            // Add more account-related UI elements here
        }
    }
}

struct AccountDetailView: View {
    var body: some View {
        VStack {
            Text("Account Details")
                .font(.largeTitle)
                .padding()
            // Add more account-related UI elements here
        }
    }
}
