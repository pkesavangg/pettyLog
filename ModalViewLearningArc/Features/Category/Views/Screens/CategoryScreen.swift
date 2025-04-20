//
//  CategoryScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//

import SwiftUI

struct CategoryScreen: View {
    @Environment(CategoryAggregateModel.self) var categoryModel
    @Environment(\.appTheme) private var theme
    @EnvironmentObject private var router: Router<SettingsRoute>
    let lang = CategoryScreenStrings.self
    
    var body: some View {
        VStack(spacing: 16) {
            RedactableList(isLoading: categoryModel.isLoading, placeholderCount: 5) {
                ForEach(categoryModel.categories) { category in
                    Button {
                        router.navigate(to: .addEditCategory(category))
                    } label: {
                        HStack {
                            CategoryIconView(iconName: category.icon)
                            Text(category.name)
                                .foregroundColor(theme.onSurface)
                            Spacer()
                            Image(systemName: AppAssets.chevronRight)
                                .foregroundColor(theme.onSurface.opacity(0.5))
                        }
                        .padding(.vertical, .p2)
                    }
                }
            }
            Button {
                router.navigate(to: .addEditCategory(nil))
            } label: {
                HStack {
                    Image(systemName: AppAssets.plus)
                    Text(lang.createNewCategory)
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(theme.primary)
                .background(theme.primary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
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
    CategoryScreen()
        .environment(CategoryAggregateModel(authModel: AuthAggregateModel()))
        .environmentObject(ThemeManager.shared)
        .environmentObject(Router<SettingsRoute>())
}

