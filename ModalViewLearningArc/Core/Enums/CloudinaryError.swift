//
//  CloudinaryError.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 26/04/25.
//
import Foundation

/// Custom errors for Cloudinary service
enum CloudinaryError: Error, LocalizedError {
    case imageConversionFailed
    case noDataReceived
    case multipleUploadsFailed(failedCount: Int)
    
    var errorDescription: String? {
        switch self {
        case .imageConversionFailed:
            return "Failed to convert image to JPEG data"
        case .noDataReceived:
            return "No data received from server"
        case .multipleUploadsFailed(let count):
            return "Failed to upload \(count) images"
        }
    }
}
