//
//  EntryModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation

struct EntryModel: Identifiable, Codable, Hashable {
    var id: String
    var date: String
    var amount: Double
    var description: String
    var imageURLs: [String]
    var category: String // Category id
    var tags: [String]? // Tag ids
}
