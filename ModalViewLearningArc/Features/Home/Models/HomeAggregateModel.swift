//
//  HomeStore.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import Foundation
import SwiftUI

@Observable
@MainActor
final class HomeAggregateModel {
    var entries: [EntryModel] = []
    var isLoading = false
    var error: String?

    // Monthly expense data
    private(set) var monthlyExpenses: [MonthlyExpense] = []

    // Selected month for detailed view
    var selectedMonth: Date = Date().startOfMonth()

    private let authModel: AuthAggregateModel
    private let entryService: EntryService

    init(authModel: AuthAggregateModel) {
        self.authModel = authModel
        self.entryService = EntryService()
        print("HomeAggregateModel initialized with authModel:")
    }

    func loadEntries() async {
        guard authModel.currentUser != nil else { return }
        isLoading = true
        error = nil
        do {
            // Get entries from the service
            entries = try await entryService.getEntries()

            // Calculate monthly expenses
            calculateMonthlyExpenses()
        } catch {
            self.error = "Failed to load entries"
        }
        isLoading = false
    }

    // Calculate monthly expenses from entries
    private func calculateMonthlyExpenses() {
        // Group entries by month
        let groupedByMonth = Dictionary(grouping: entries) { entry -> Date in
            guard let date = DateFormatter.fullTimestampFormatter.date(from: entry.date) else {
                return Date()
            }
            return date.startOfMonth()
        }

        // Convert to MonthlyExpense objects
        var expenses: [MonthlyExpense] = []

        for (month, monthEntries) in groupedByMonth {
            let totalAmount = monthEntries.reduce(0) { $0 + $1.amount }
            let expense = MonthlyExpense(
                date: month,
                amount: totalAmount,
                entriesCount: monthEntries.count
            )
            expenses.append(expense)
        }

        // Sort by date (oldest to newest)
        monthlyExpenses = expenses.sorted { $0.date < $1.date }
    }

    // Get the most recent months (up to count)
    func getRecentMonths(count: Int = 4) -> [MonthlyExpense] {
        let sorted = monthlyExpenses.sorted { $0.date > $1.date }
        return Array(sorted.prefix(count))
    }

    // Calculate average monthly expense
    var averageMonthlyExpense: Double {
        guard !monthlyExpenses.isEmpty else { return 0 }
        let total = monthlyExpenses.reduce(0) { $0 + $1.amount }
        return total / Double(monthlyExpenses.count)
    }

    // Get month-over-month percentage change for the most recent month
    var latestMonthPercentageChange: Double? {
        guard monthlyExpenses.count >= 2 else { return nil }

        let sorted = monthlyExpenses.sorted { $0.date > $1.date }
        let latest = sorted[0]
        let previous = sorted[1]

        return latest.percentageChange(from: previous)
    }

    // Generate sample data for preview
    static func withSampleData() -> HomeAggregateModel {
        let model = HomeAggregateModel(authModel: AuthAggregateModel())

        // Create sample monthly expenses for the last 6 months
        let calendar = Calendar.current
        var date = Date()
        var sampleExpenses: [MonthlyExpense] = []

        for i in 0..<6 {
            // Go back i months from current date
            guard let monthDate = calendar.date(byAdding: .month, value: -i, to: date) else { continue }

            // Random amount between 1000 and 5000
            let amount = Double.random(in: 1000...5000)
            let entriesCount = Int.random(in: 5...15)

            let expense = MonthlyExpense(
                date: monthDate.startOfMonth(),
                amount: amount,
                entriesCount: entriesCount
            )
            sampleExpenses.append(expense)
        }

        model.monthlyExpenses = sampleExpenses.sorted { $0.date < $1.date }
        return model
    }
}
