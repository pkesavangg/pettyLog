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


    private var categoriesPath: CollectionReference {
        db.collection("categories")
    }

    func addCategory(_ category: CategoryModel) async throws {
        let ref = categoriesPath.document(category.id)
        try ref.setData(from: category) // ✅ Encodes all properties into Firestore
    }

    func getCategories() async throws -> [CategoryModel] {
        let snapshot = try await categoriesPath.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: CategoryModel.self)
        }
    }

    func updateCategory(_ category: CategoryModel) async throws {
        let ref = categoriesPath.document(category.id)
        try ref.setData(from: category, merge: true)
    }

    func deleteCategory(withId id: String) async throws {
        try await categoriesPath.document(id).delete()
    }
}

