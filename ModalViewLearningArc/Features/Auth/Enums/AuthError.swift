//
//  AuthError.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation

enum AuthError: Error, LocalizedError {
    case invalidEmail
    case incorrectPassword
    case accountNotFound
    case duplicateAccount
    case weakPassword
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return ErrorMessages.Auth.invalidEmail
        case .accountNotFound:
            return ErrorMessages.Auth.accountNotFound
        case .duplicateAccount:
            return ErrorMessages.Auth.duplicateAccount
       case .weakPassword:
            return ErrorMessages.Auth.weakPassword
            case .incorrectPassword:
            return ErrorMessages.Auth.incorrectPassword
        case .custom(let message):
            return message
        }
    }
}

