//
//  FormValidator.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//


import Foundation

enum FormValidator {
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    static func isEmpty(_ value: String) -> Bool {
        value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    static func isLengthValid(_ value: String, min: Int = 6) -> Bool {
        value.count >= min
    }

    static func doPasswordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
        password == confirmPassword
    }
}
