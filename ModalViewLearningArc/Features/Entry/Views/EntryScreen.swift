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
    let lang = EntryScreenStrings.self
    var body: some View {
        RoutingView(stack: $router.stack) {
            RedactableList(isLoading: entryModel.isLoading,
                           placeholderCount: 10) {
                ForEach(entryModel.entries) { entry in
                    Button {
                        router.navigate(to: .addEditEntry(entry))
                    } label: {
                        EntryListRowView(
                                        entry: entry,
                                        categories: entryModel.getCategories(),
                                        tags: entryModel.getTags()
                                    )
                    }
                }
            }
            .navigationTitle(lang.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        router.navigate(to: .addEditEntry(nil))
                    } label: {
                        Image(systemName: AppAssets.plus)
                            .foregroundColor(.primary)
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
