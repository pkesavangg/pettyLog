//
//  CategoryAggregateModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class CategoryAggregateModel {
    var categories: [CategoryModel] = []
    private let authModel: AuthAggregateModel
    private let service: CategoryService
    var isLoading: Bool = true
    
    init(authModel: AuthAggregateModel) {
        self.authModel = authModel
        self.service = CategoryService(userId: authModel.currentUser?.uid ?? "unknown")
        Task {
            await loadCategories()
        }
        print("CategoryAggregateModel initialized with authModel:")
    }

    func loadCategories() async {
        isLoading = true
        do {
            categories = try await service.getCategories()
        } catch {
            print("Failed to load categories: \(error)")
        }
        isLoading = false
    }

    func saveCategory(_ category: CategoryModel) async {
        do {
            try await service.addCategory(category)
            await loadCategories()
        } catch {
            print("Failed to save category: \(error)")
        }
    }
    
    func updateCategory(_ category: CategoryModel) async {
        do {
            try await service.updateCategory(category)
            await loadCategories()
        } catch {
            print("Failed to update category: \(error)")
        }
    }
    
    func deleteCategory(id: String) async {
        do {
            try await service.deleteCategory(withId: id)
            await loadCategories()
        } catch {
            print("Failed to delete category: \(error)")
        }
    }
}

