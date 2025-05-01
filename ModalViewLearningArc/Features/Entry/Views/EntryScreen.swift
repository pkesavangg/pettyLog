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
            VStack(spacing: 0) {
                // Month selector at the top
                if !entryModel.entries.isEmpty {
                    getMonthView()
                    // Total expense header
                    if !entryModel.entriesForSelectedMonth.isEmpty && !entryModel.isLoading {
                        
                        MonthTotalHeaderView(
                            totalAmount: entryModel.totalExpenseForSelectedMonth,
                            entriesCount: entryModel.entriesForSelectedMonth.count
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top, .p8)
                        .padding(.horizontal)
                    }
                }

                // Entries for selected month
                if entryModel.entries.isEmpty && !entryModel.isLoading {
                    List {
                        Text(lang.noEntriesAvailable)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.semibold)
                            .foregroundColor(theme.onSurface)
                    }
                } else if entryModel.entriesForSelectedMonth.isEmpty && !entryModel.isLoading {
                    List {
                        Text("No entries for \(entryModel.selectedMonth.formattedMonthYear())")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.semibold)
                            .foregroundColor(theme.onSurface)
                    }
                } else {
                    Group {
                        if entryModel.isLoading {
                            RedactableList(isLoading: true, placeholderCount: 5) {
                                EmptyView()
                            }
                        } else {
                            DateGroupedEntryListView(
                                entries: entryModel.entriesForSelectedMonth,
                                categories: entryModel.getCategories(),
                                tags: entryModel.getTags(),
                                onEntryTap: { entry in
                                    router.navigate(to: .entryDetail(entry))
                                }
                            )
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

    public func getMonthView() -> some View {
        @Bindable var bindableTestViewModel = entryModel

        return MonthSelectorView(
            selectedMonth: $bindableTestViewModel.selectedMonth,
            availableMonths: entryModel.availableMonths
        )
        .padding(.top, 8)
    }

}

#Preview {
    EntryScreen()
        .environment(EntryAggregateModel(authModel: AuthAggregateModel(),
                                         categoryModel: CategoryAggregateModel(authModel: AuthAggregateModel()),
                                         tagModel:    TagAggregateModel(authModel: AuthAggregateModel()))
        )
}
