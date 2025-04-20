//
//  ProfileTabView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @Environment(\.appTheme) private var theme
    @StateObject var router: Router<SettingsRoute> = .init()
    var settingAggregateModel: SettingsAggregateModel = .init()
    
    @State private var showLogoutAlert = false
    var lang = SettingScreenStrings.self
    var commonLang = CommonStrings.self
    var alertLang = AlertMessages.Logout.self
    
    var body: some View {
        RoutingView(stack: $router.stack) {
            VStack {
                List {
                    profileSection
                    configurationSection
                    otherOptionsSection
                }
            }
            .navigationTitle(CommonStrings.settings)
            .scrollContentBackground(.hidden)
            .background(LinearGradient(colors: [theme.primary.opacity(0.2), .white], startPoint: .top, endPoint: .bottom))
        }
        .environmentObject(router)
        .environment(settingAggregateModel)

        .accentColor(theme.primary)
    }
}

private extension SettingsScreen {
    
    var profileSection: some View {
        Section(header: Text(lang.profile).foregroundColor(theme.onSurface)) {
            HStack {
                profileIcon
                NavigationLink(destination: AccountDetailView()) {
                    VStack(alignment: .leading) {
                        Text(authModel.currentUser?.firstName ?? "")
                            .foregroundColor(theme.onSurface)
                        Text(authModel.currentUser?.email ?? "")
                            .font(.caption)
                            .foregroundColor(theme.secondary)
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
            .foregroundColor(theme.primary)
            .overlay {
                Image(systemName: AppAssets.personCrop)
                    .font(.title)
                    .foregroundColor(theme.onPrimary)
            }
    }

    var configurationSection: some View {
        Section(header: Text(lang.configure).foregroundColor(theme.onSurface)) {
            Button {
                router.navigate(to: .categories)
            } label: {
                HStack {
                    Text(CommonStrings.categories)
                        .foregroundColor(theme.onBackground)
                    Spacer()

                    Image(systemName: AppAssets.chevronRight)
                        .foregroundColor(theme.onSurface.opacity(0.5))
                }
            }
            
            Button {
                router.navigate(to: .Tags)
            } label: {
                HStack {
                    Text(CommonStrings.tags)
                        .foregroundColor(theme.onBackground)
                    Spacer()

                    Image(systemName: AppAssets.chevronRight)
                        .foregroundColor(theme.onSurface.opacity(0.5))
                }
            }
            
            Button {
                router.navigate(to: .Theme)
            } label: {
                HStack {
                    Text(CommonStrings.theme)
                        .foregroundColor(theme.onBackground)
                    Spacer()

                    Image(systemName: AppAssets.chevronRight)
                        .foregroundColor(theme.onSurface.opacity(0.5))
                }
            }
        }
    }

    var otherOptionsSection: some View {
        Section(header: Text(lang.others).foregroundColor(theme.onSurface)) {
            Text(lang.rateUs)
                .foregroundColor(theme.onSurface)
            
            Text(lang.logout)
                .foregroundColor(theme.error)
                .onTapGesture {
                    showLogoutAlert = true
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text(alertLang.title),
                        primaryButton: .default(Text(commonLang.yes.uppercased())) {
                            do {
                                try authModel.logout()
                            } catch {
                                print("Logout error: \(error)")
                            }
                        },
                        secondaryButton: .cancel(Text(commonLang.cancel.uppercased()))
                    )
                }

            Text(lang.aboutUs)
                .foregroundColor(theme.onSurface)
        }
    }
}


#Preview {
     SettingsScreen()
        .environmentObject(ThemeManager.shared)
        .environmentObject(Router<SettingsRoute>())
        .environment(AuthAggregateModel())
}
