//
//  CloudinaryConfig.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation

/// Configuration for Cloudinary service
struct CloudinaryConfig {
    /// Cloudinary cloud name
    static let cloudName = "drvtbf98f"
    
    /// Cloudinary API key
    static let apiKey = "111667813955433"
    
    /// Cloudinary API secret
    static let apiSecret = "I7ZDv-AWqaZ8e1J-UFOY_OyPCGA"
    
    /// Base URL for Cloudinary API
    static var uploadURL: URL {
        URL(string: "https://api.cloudinary.com/v1_1/\(cloudName)/image/upload")!
    }
}
