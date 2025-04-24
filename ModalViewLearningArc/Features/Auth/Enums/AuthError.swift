//
//  AuthError.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation

enum BiometricType {
    case faceID
    case touchID
    case none
}

enum AuthError: Error, LocalizedError {
    case invalidEmail
    case incorrectPassword
    case accountNotFound
    case duplicateAccount
    case weakPassword
    case custom(String)
    case deniedAccess
    case noFaceIdEnrolled
    case noFingerprintEnrolled
    case biometricError
    case credentialsNotSaved
    
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
        case .deniedAccess:
            return ErrorMessages.Auth.biometricAccessDenied
        case .noFaceIdEnrolled:
            return ErrorMessages.Auth.noFaceIdEnrolled
        case .noFingerprintEnrolled:
            return ErrorMessages.Auth.noFingerprintEnrolled
        case .biometricError:
            return ErrorMessages.Auth.biometricVerificationFailed
        case .credentialsNotSaved:
            return ErrorMessages.Auth.credentialsNotSaved
        case .custom(let message):
            return message
        }
    }
}

