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

    private let authModel: AuthAggregateModel

    init(authModel: AuthAggregateModel) {
        self.authModel = authModel
    }

    func loadEntries() async {
        guard let email = authModel.currentUser?.email else { return }
        isLoading = true
        error = nil
        do {
            // Simulate an API call
            try await Task.sleep(nanoseconds: 1_000_000_000)
            // Fetch based on user email
            entries = dummyEntriesFor(email: email)
        } catch {
            self.error = "Failed to load entries"
        }
        isLoading = false
    }

    private func dummyEntriesFor(email: String) -> [EntryModel] {
        // This will later be replaced with a real API call
        return [
            EntryModel(id: "UUID()", date: .now, amount: 150.0, description: "Team Snacks", imageURLs: [""]),
            EntryModel(id: "UUIDs()", date: .now, amount: 300.0, description: "Postage", imageURLs: [""])
        ]
    }
}
