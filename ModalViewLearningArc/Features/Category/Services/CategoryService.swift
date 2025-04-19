//
//  CategoryService.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//


import Foundation
import FirebaseFirestore

final class CategoryService {
    private let db = Firestore.firestore()
    private var userId: String

    init(userId: String) {
        self.userId = userId
    }

    private var userCategoriesPath: CollectionReference {
        db.collection("users").document(userId).collection("categories")
    }

    func addCategory(_ category: CategoryModel) async throws {
        let ref = userCategoriesPath.document(category.id)
        try ref.setData(from: category) // ✅ Encodes all properties into Firestore
    }

    func getCategories() async throws -> [CategoryModel] {
        let snapshot = try await userCategoriesPath.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: CategoryModel.self)
        }
    }

    func updateCategory(_ category: CategoryModel) async throws {
        let ref = userCategoriesPath.document(category.id)
        try ref.setData(from: category, merge: true)
    }

    func deleteCategory(withId id: String) async throws {
        try await userCategoriesPath.document(id).delete()
    }
}

