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
            return "You denied biometrics access to the app. If you want to enable it, go to Settings > ModalViewLearningArc and enable biometrics."
        case .noFaceIdEnrolled:
            return "You have not registered any faces."
        case .noFingerprintEnrolled:
            return "You have not registered any fingerprints."
        case .biometricError:
            return "Your face or fingerprint could not be verified."
        case .credentialsNotSaved:
            return "Your credentials have not been saved. Do you want to save them in next successful login?"
        case .custom(let message):
            return message
        }
    }
}

