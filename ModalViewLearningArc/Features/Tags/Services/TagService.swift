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


    private var tagsPath: CollectionReference {
        db.collection("tags")
    }

    func addTag(_ tag: TagModel) async throws {
        let ref = tagsPath.document(tag.id)
        try ref.setData(from: tag)
    }

    func getTags() async throws -> [TagModel] {
        let snapshot = try await tagsPath.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: TagModel.self)
        }
    }

    func updateTag(_ tag: TagModel) async throws {
        let ref = tagsPath.document(tag.id)
        try ref.setData(from: tag, merge: true)
    }

    func deleteTag(withId id: String) async throws {
        try await tagsPath.document(id).delete()
    }
}
