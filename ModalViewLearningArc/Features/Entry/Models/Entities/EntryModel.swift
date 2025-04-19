//
//  EntryModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation

struct EntryModel: Identifiable, Codable {
    var id: String
    var date: Date
    var amount: Double
    var description: String
    var imageURLs: [String]
    var category: CategoryModel = CategoryModel(id: "sdfsdf", name: "Uncategorized", icon: "home", color: "#ffffff", dateCreated: Date().description, isDefault: false)
}
