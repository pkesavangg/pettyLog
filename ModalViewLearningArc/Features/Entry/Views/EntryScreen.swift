//
//  EntryScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//

import SwiftUI

struct EntryScreen: View {
    @Environment(EntryAggregateModel.self) var entryModel
    @StateObject var router: Router<EntryRoute> = .init()
    @Environment(\.appTheme) private var theme
    let lang = EntryScreenStrings.self
    var body: some View {
        RoutingView(stack: $router.stack) {
            VStack {
                if entryModel.entries.isEmpty && !entryModel.isLoading {
                    List {
                        Text(lang.noEntriesAvailable)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.semibold)
                            .foregroundColor(theme.onSurface)
                    }
                } else {
                    RedactableList(isLoading: entryModel.isLoading,
                                   placeholderCount: 5) {
                        ForEach(entryModel.entries) { entry in
                            Button {
                                router.navigate(to: .entryDetail(entry))
                            } label: {
                                EntryListRowView(
                                    entry: entry,
                                    categories: entryModel.getCategories(),
                                    tags: entryModel.getTags()
                                )
                            }
                        }
                    }
                }
            }
            .listScreenStyle(title: lang.title, tabBarHidden: false)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        Button {
                            // TODO: Implement sort and filter action
                        } label: {
                            Image(systemName: AppAssets.lineDecrease)
                                .foregroundColor(theme.primary)
                        }
                        
                        Button {
                            router.navigate(to: .addEditEntry(nil))
                        } label: {
                            Image(systemName: AppAssets.plus)
                                .foregroundColor(theme.primary)
                        }
                    }
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    EntryScreen()
        .environment(EntryAggregateModel(authModel: AuthAggregateModel(),
                                         categoryModel: CategoryAggregateModel(authModel: AuthAggregateModel()),
                                         tagModel:    TagAggregateModel(authModel: AuthAggregateModel()))
        )
}
