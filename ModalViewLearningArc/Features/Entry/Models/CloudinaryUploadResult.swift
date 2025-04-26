//
//  CloudinaryUploadResult.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation

// Model for Cloudinary response
struct CloudinaryUploadResult: Codable {
    // Required fields
    let secure_url: String

    // Optional fields that might be present in the response
    let public_id: String?
    let format: String?
    let version: Int?
    let resource_type: String?
    let created_at: String?
    let bytes: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let asset_id: String?
    let original_filename: String?
    let tags: [String]?

    // Add more fields as needed based on Cloudinary's response
}

// Helper to append Data
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
