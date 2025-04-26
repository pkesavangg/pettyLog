//
//  CloudinaryService.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation
import UIKit
import CryptoKit

/// Service for handling Cloudinary image uploads
class CloudinaryService {
    
    /// Singleton instance
    static let shared = CloudinaryService()
    
    private init() {}
    
    /// Upload an image to Cloudinary using signed upload
    /// - Parameters:
    ///   - image: The UIImage to upload
    ///   - completion: Callback with result containing the secure URL or an error
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(CloudinaryError.imageConversionFailed))
            return
        }
        
        // Create the upload request
        var request = URLRequest(url: CloudinaryConfig.uploadURL)
        request.httpMethod = "POST"
        
        // Set up multipart form data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the request body
        var body = Data()
        
        // Generate timestamp
        let timestamp = Int(Date().timeIntervalSince1970)
        
        // Add API key
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"api_key\"\r\n\r\n")
        body.append("\(CloudinaryConfig.apiKey)\r\n")
        
        // Add timestamp
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"timestamp\"\r\n\r\n")
        body.append("\(timestamp)\r\n")
        
        // Generate signature
        let signatureString = "timestamp=\(timestamp)"
        let signature = Insecure.SHA1.hash(data: Data((signatureString + CloudinaryConfig.apiSecret).utf8))
            .map { String(format: "%02x", $0) }
            .joined()
        
        // Add signature
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"signature\"\r\n\r\n")
        body.append("\(signature)\r\n")
        
        // Append image file
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        // Perform the upload
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CloudinaryError.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CloudinaryUploadResult.self, from: data)
                completion(.success(result.secure_url))
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Cloudinary Error Response: \(jsonString)")
                }
                completion(.failure(error))
            }
        }.resume()
    }
    
    /// Upload multiple images to Cloudinary
    /// - Parameters:
    ///   - images: Array of UIImages to upload
    ///   - completion: Callback with array of secure URLs or an error
    func uploadImages(_ images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) {
        guard !images.isEmpty else {
            completion(.success([]))
            return
        }
        
        var uploadedUrls: [String] = []
        var failedUploads = 0
        let dispatchGroup = DispatchGroup()
        
        for image in images {
            dispatchGroup.enter()
            
            uploadImage(image) { result in
                switch result {
                case .success(let url):
                    uploadedUrls.append(url)
                case .failure(let error):
                    failedUploads += 1
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if failedUploads > 0 {
                completion(.failure(CloudinaryError.multipleUploadsFailed(failedCount: failedUploads)))
            } else {
                completion(.success(uploadedUrls))
            }
        }
    }
}
