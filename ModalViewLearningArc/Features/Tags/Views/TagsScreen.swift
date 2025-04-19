//
//  TagsScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//

import SwiftUI

struct TagsScreen: View {
    @Environment(TagAggregateModel.self) var tagModel
    @Environment(\.appTheme) private var theme
    @EnvironmentObject private var router: Router<SettingsRoute>
    let lang = TagScreenStrings.self
    
    var body: some View {
        VStack(spacing: 16) {
            if tagModel.tags.isEmpty && !tagModel.isLoading {
                List {
                    Text(lang.emptyTagList)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.onSurface)
                }
            } else {
                RedactableList(isLoading: tagModel.isLoading, placeholderCount: 5) {
                        ForEach(tagModel.tags) { tag in
                            Button {
                                router.navigate(to: .addEditTag(tag))
                            } label: {
                                HStack {
                                    TagChipView(tag: tag)
                                    Spacer()
                                    Image(systemName: AppAssets.chevronRight)
                                        .foregroundColor(theme.onSurface.opacity(0.5))
                                }
                                .padding(.vertical, .p2)
                            }
                        }
                }
            }
            Button {
                router.navigate(to: .addEditTag(nil))
            } label: {
                HStack {
                    Image(systemName: AppAssets.plus)
                    Text(lang.createNewTag)
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
    TagsScreen()
        .environment(TagAggregateModel(authModel: AuthAggregateModel()))
        .environmentObject(ThemeManager.shared)
}

