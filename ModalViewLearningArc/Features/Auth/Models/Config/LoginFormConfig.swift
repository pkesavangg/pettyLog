//
//  LoginFormConfig.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//

import SwiftUI

struct LoginFormConfig {
    var email: String = ""
    var password: String = ""

    var isEmailValid: Bool {
        FormValidator.isValidEmail(email)
    }

    var isPasswordValid: Bool {
        !FormValidator.isEmpty(password)
    }

    var isValid: Bool {
        isEmailValid && isPasswordValid
    }

    var validationErrorMessage: String? {
        if FormValidator.isEmpty(email) {
            return ErrorMessages.Validation.emailRequired
        } else if !isEmailValid {
            return ErrorMessages.Validation.invalidEmail
        } else if FormValidator.isEmpty(password) {
            return ErrorMessages.Validation.passwordRequired
        } else {
            return nil
        }
    }
}
