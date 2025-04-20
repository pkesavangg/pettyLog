//
//  EntryAggregateModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import Foundation

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

    init(authModel: AuthAggregateModel,
         categoryModel: CategoryAggregateModel,
         tagModel: TagAggregateModel) {
        self.authModel = authModel
        self.categoryModel = categoryModel
        self.tagModel = tagModel
        self.service = EntryService(userId: authModel.currentUser?.uid ?? "unknown")

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
        } catch {
            print("Failed to load entries: \(error)")
        }
    }

    func saveEntry(_ entry: EntryModel) async {
        
            isLoading = true
            defer { isLoading = false }
            do {
                try await service.addEntry(entry)
                await loadEntries()
            } catch {
                print("Failed to save entry: \(error)")
            }
        
    }

    func updateEntry(_ entry: EntryModel) {
        Task {
            isLoading = true
            defer { isLoading = false }

            do {
                try await service.updateEntry(entry)
                await loadEntries()
            } catch {
                print("Failed to update entry: \(error)")
            }
        }
    }

    func deleteEntry(id: String) {
        Task {
            isLoading = true
            defer { isLoading = false }

            do {
                try await service.deleteEntry(withId: id)
                await loadEntries()
            } catch {
                print("Failed to delete entry: \(error)")
            }
        }
    }
}

