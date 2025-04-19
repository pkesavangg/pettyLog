//
//  TagAggregateModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//
import Foundation
import SwiftUI

@Observable
@MainActor
final class TagAggregateModel {
    var tags: [TagModel] = []
    var isLoading: Bool = true

    private let authModel: AuthAggregateModel
    private let service: TagService

    init(authModel: AuthAggregateModel) {
        self.authModel = authModel
        self.service = TagService(userId: authModel.currentUser?.uid ?? "unknown")
        Task {
            await loadTags()
        }
    }

    func loadTags() async {
        isLoading = true
        do {
            tags = try await service.getTags()
        } catch {
            print("Failed to load tags: \(error)")
        }
        isLoading = false
    }

    func saveTag(_ tag: TagModel) async {
        do {
            try await service.addTag(tag)
            await loadTags()
        } catch {
            print("Failed to save tag: \(error)")
        }
    }

    func updateTag(_ tag: TagModel) async {
        do {
            try await service.updateTag(tag)
            await loadTags()
        } catch {
            print("Failed to update tag: \(error)")
        }
    }

    func deleteTag(id: String) async {
        do {
            try await service.deleteTag(withId: id)
            await loadTags()
        } catch {
            print("Failed to delete tag: \(error)")
        }
    }
}
