//
//  EntryService.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import Foundation
import FirebaseFirestore

final class EntryService {
    private let db = Firestore.firestore()
    private var userId: String

    init(userId: String) {
        self.userId = userId
    }

    private var userEntriesPath: CollectionReference {
        db.collection("users").document(userId).collection("entries")
    }

    func addEntry(_ entry: EntryModel) async throws {
        let ref = userEntriesPath.document(entry.id)
        try ref.setData(from: entry) // Firestore Codable support
    }

    func getEntries() async throws -> [EntryModel] {
        let snapshot = try await userEntriesPath.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: EntryModel.self)
        }
    }

    func updateEntry(_ entry: EntryModel) async throws {
        let ref = userEntriesPath.document(entry.id)
        try ref.setData(from: entry, merge: true)
    }

    func deleteEntry(withId id: String) async throws {
        try await userEntriesPath.document(id).delete()
    }
}
