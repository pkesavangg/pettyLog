//
//  Endpoints.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import Foundation

enum API {
    static let baseURL = "https://api.example.com"
}

enum Endpoint {
    case entries(email: String)
    case signup
    case login

    var urlRequest: URLRequest? {
        switch self {
        case .entries(let email):
            guard let url = URL(string: "\(API.baseURL)/entries?email=\(email)") else { return nil }
            return URLRequest(url: url)

        case .signup:
            guard let url = URL(string: "\(API.baseURL)/signup") else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request

        case .login:
            guard let url = URL(string: "\(API.baseURL)/login") else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
    }
}

