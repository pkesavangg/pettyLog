//
//  CategoryModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//


import Foundation
import SwiftUI

struct CategoryModel: Identifiable, Codable, Hashable {
    var id: String             // Firebase document ID
    var name: String           // e.g., "Food", "Travel"
    var icon: String           // SF Symbol name or image name
    var color: String          // Store hex like "#FF5733"
    var dateCreated: String    // Date when the category was created
    var isDefault: Bool       // Indicates if it's a default category
    var displayColor: Color {
        if let uiColor = UIColor(hex: color) {
            return Color(uiColor) // Convert UIColor to Color
        }
        return Color.clear // Fallback if hex conversion fails
    }
}
