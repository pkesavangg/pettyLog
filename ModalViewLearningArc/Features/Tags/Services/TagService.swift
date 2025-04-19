//
//  TagService.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//


import Foundation
import FirebaseFirestore

final class TagService {
    private let db = Firestore.firestore()
    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    private var userTagsPath: CollectionReference {
        db.collection("users").document(userId).collection("tags")
    }

    func addTag(_ tag: TagModel) async throws {
        let ref = userTagsPath.document(tag.id)
        try ref.setData(from: tag)
    }

    func getTags() async throws -> [TagModel] {
        let snapshot = try await userTagsPath.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: TagModel.self)
        }
    }

    func updateTag(_ tag: TagModel) async throws {
        let ref = userTagsPath.document(tag.id)
        try ref.setData(from: tag, merge: true)
    }

    func deleteTag(withId id: String) async throws {
        try await userTagsPath.document(id).delete()
    }
}
