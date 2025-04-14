//
//  NetworkError.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case statusCode(Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid server response"
        case .decodingError: return "Failed to decode response"
        case .statusCode(let code): return "Server error with status code \(code)"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
