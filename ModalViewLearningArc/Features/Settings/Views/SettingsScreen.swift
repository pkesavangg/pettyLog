//
//  ProfileTabView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(\.dismiss) private var dismiss
    @StateObject var router: Router<SettingsRoute> = .init()
    var settingAggregateModel: SettingsAggregateModel = .init()
    
    @State private var showLogoutAlert = false
    
    var body: some View {
        RoutingView(stack: $router.stack) {
            VStack {
                List {
                    profileSection
                    configurationSection
                    otherOptionsSection
                }
            }
            .navigationTitle("Settings")
        }
        .environmentObject(router)
        .environment(settingAggregateModel)
    }
}


private extension SettingsScreen {
    var profileSection: some View {
        Section(header: Text("profile")) {
            HStack {
                profileIcon
                NavigationLink(destination: AccountDetailView()) {
                    VStack(alignment: .leading) {
                        Text(authModel.currentUser?.firstName ?? "")
                        Text(authModel.currentUser?.email ?? "")
                            .foregroundColor(.green)
                    }
                }
                .padding(.leading, 5)
                Spacer()
            }
        }
    }
    
    var profileIcon: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(.green)
            .overlay {
                Image(systemName: "person.crop.circle")
                    .font(.title)
                    .foregroundColor(.white)
            }
    }
    
    
    var configurationSection: some View {
        Section(header: Text("Configure")) {
            NavigationLink(destination: CategoryView()) {
                Text("Categories")
            }
            
            NavigationLink(destination: CategoryView()) {
                Text("Tags")
            }
        }
    }
    
    
    var otherOptionsSection: some View {
        Section(header: Text("Others")) {
            Text("Rate Us")
            Text("Logout")
                .onTapGesture {
                    showLogoutAlert = true
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(title: Text("Are you sure you want to logout?"),
                          primaryButton: .default(Text("YES"),                                 action: {
                        do {
                            try authModel.logout()
                        } catch {
                            print("Logout error: \(error)")
                        }
                    }), secondaryButton: .default(Text("CANCEL")))
                }
            Text("About Us")
            
        }
    }
}
