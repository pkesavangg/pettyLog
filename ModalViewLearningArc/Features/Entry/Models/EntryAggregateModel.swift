//
//  EntryAggregateModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import Foundation

let dummyEntries: [EntryModel] = [
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-20T12:00:00+0000",
        amount: 199.99,
        description: "Grocery shopping at Market",
        imageURLs: [],
        category: "groceries",
        tags: ["food", "weekly"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-19T09:15:00+0000",
        amount: 49.00,
        description: "Coffee and breakfast",
        imageURLs: [],
        category: "eating_out",
        tags: ["morning"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-18T18:30:00+0000",
        amount: 320.00,
        description: "Monthly rent",
        imageURLs: [],
        category: "housing",
        tags: ["monthly", "important"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-17T15:00:00+0000",
        amount: 12.50,
        description: "Bus ticket",
        imageURLs: [],
        category: "transport",
        tags: ["commute"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-16T20:45:00+0000",
        amount: 150.00,
        description: "Dinner at Italian place",
        imageURLs: [],
        category: "eating_out",
        tags: ["friends", "weekend"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-15T13:20:00+0000",
        amount: 35.00,
        description: "New books from bookstore",
        imageURLs: [],
        category: "education",
        tags: ["books", "learning"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-14T11:00:00+0000",
        amount: 80.75,
        description: "Utility bill payment",
        imageURLs: [],
        category: "utilities",
        tags: ["monthly"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-13T08:00:00+0000",
        amount: 20.00,
        description: "Gym session",
        imageURLs: [],
        category: "health",
        tags: ["fitness"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-12T19:00:00+0000",
        amount: 60.00,
        description: "Movie night",
        imageURLs: [],
        category: "entertainment",
        tags: ["friends", "leisure"]
    ),
    EntryModel(
        id: UUID().uuidString,
        date: "2025-04-11T16:45:00+0000",
        amount: 25.00,
        description: "Lunch with colleagues",
        imageURLs: [],
        category: "eating_out",
        tags: ["work"]
    )
]


@Observable
@MainActor
final class EntryAggregateModel {
    var entry: EntryModel?
    var authModel: AuthAggregateModel
    var categoryModel: CategoryAggregateModel
    var tagModel: TagAggregateModel
    var isEditing = false

    private let service: EntryService
    var entries: [EntryModel] = []
    var isLoading: Bool = true

    // Month-based filtering
    var selectedMonth: Date = Date().startOfMonth()

    // Method to find the latest month with entries
    func findLatestMonthWithEntries() -> Date {
        let dates = entries.compactMap { entry in
            DateFormatter.fullTimestampFormatter.date(from: entry.date)
        }

        if let latestDate = dates.max() {
            return latestDate.startOfMonth()
        }

        return Date().startOfMonth()
    }

    // Computed property to get entries for the selected month
    var entriesForSelectedMonth: [EntryModel] {
        entries.filter { entry in
            guard let entryDate = DateFormatter.fullTimestampFormatter.date(from: entry.date) else {
                return false
            }
            return entryDate.isSameMonth(as: selectedMonth)
        }
    }

    // Computed property to calculate total expense for the selected month
    var totalExpenseForSelectedMonth: Double {
        entriesForSelectedMonth.reduce(0) { $0 + $1.amount }
    }

    // Computed property to get all available months from entries
    var availableMonths: [Date] {
        let dates = entries.compactMap { entry in
            DateFormatter.fullTimestampFormatter.date(from: entry.date)
        }

        guard let oldestDate = dates.min(),
              let newestDate = dates.max() else {
            return [Date().startOfMonth()]
        }

        return Date.monthsBetween(start: oldestDate, end: newestDate).reversed()
    }

    init(authModel: AuthAggregateModel,
         categoryModel: CategoryAggregateModel,
         tagModel: TagAggregateModel) {
        self.authModel = authModel
        self.categoryModel = categoryModel
        self.tagModel = tagModel
        self.service = EntryService()

        Task {
            await loadEntries()
        }
    }

    func getCategories() -> [CategoryModel] {
        return categoryModel.categories
    }

    func getTags() -> [TagModel] {
        return tagModel.tags
    }

    func loadEntries() async {
        isLoading = true
        defer { isLoading = false }

        do {
            entries = try await service.getEntries()

            // Select the latest month with entries if there are any
            if !entries.isEmpty {
                selectedMonth = findLatestMonthWithEntries()
            }
        } catch {
            print("Failed to load entries: \(error)")
        }
    }

    func saveEntry(_ entry: EntryModel) async throws{

            isLoading = true
            defer { isLoading = false }
            do {
                try await service.addEntry(entry)
                await loadEntries()
            } catch {
                throw error
            }

    }

    func updateEntry(_ entry: EntryModel) async throws {
        Task {
            isLoading = true
            defer { isLoading = false }

            do {
                try await service.updateEntry(entry)
                await loadEntries()
            } catch {
                throw error
            }
        }
    }

    func deleteEntry(id: String) async throws {
            isLoading = true
            defer { isLoading = false }

            do {
                try await service.deleteEntry(withId: id)
                await loadEntries()
            } catch {
                throw error
            }
    }
}

