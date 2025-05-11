//
//  HomeScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(HomeAggregateModel.self) var homeModel
    @Environment(\.appTheme) private var theme

    @State private var showExpenseTrendDetail = false

    var body: some View {
        NavigationView {
            Group {
                if homeModel.isLoading {
                    ProgressView()
                } else if let error = homeModel.error {
                    Text(error).foregroundColor(.red)
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Monthly expense chart
                            if !homeModel.monthlyExpenses.isEmpty {
                                VStack {
                                    MonthlyExpenseChartView(
                                        monthlyExpenses: homeModel.monthlyExpenses,
                                        averageExpense: homeModel.averageMonthlyExpense
                                    )

                                    Button {
                                        showExpenseTrendDetail = true
                                    } label: {
                                        Text("View Detailed Analysis")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(theme.primary)
                                            .padding(.vertical, 8)
                                    }
                                }
                            }

                            // Recent months summary
                            RecentMonthsExpenseSummaryView(
                                recentMonths: homeModel.getRecentMonths()
                            )

                            // Recent entries
                            if !homeModel.entries.isEmpty {
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Recent Entries")
                                        .font(.headline)
                                        .foregroundColor(theme.onSurface)

                                    ForEach(Array(homeModel.entries.prefix(5))) { entry in
                                        entryRow(entry)
                                    }
                                }
                                .padding()
                                .background(theme.surface)
                                .cornerRadius(12)
                                .shadow(color: theme.onSurface.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Home")
        }
        .task {
            await homeModel.loadEntries()
        }
        .sheet(isPresented: $showExpenseTrendDetail) {
            ExpenseTrendDetailView(
                monthlyExpenses: homeModel.monthlyExpenses,
                averageExpense: homeModel.averageMonthlyExpense
            )
        }
    }

    private func entryRow(_ entry: EntryModel) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.description)
                    .font(.subheadline)
                    .foregroundColor(theme.onSurface)

                if let date = DateFormatter.fullTimestampFormatter.date(from: entry.date) {
                    Text(date.formattedDayMonth())
                        .font(.caption)
                        .foregroundColor(theme.onSurface.opacity(0.7))
                }
            }

            Spacer()

            Text("₹\(entry.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(theme.primary)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(theme.surface.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(theme.onSurface.opacity(0.1), lineWidth: 1)
        )
    }
}


#Preview {
    HomeScreen()
        .environment(HomeAggregateModel.withSampleData())
}
