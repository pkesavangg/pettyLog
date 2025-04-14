//
//  Constants.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//

// MARK: - CommonStrings.swift
struct CommonStrings {
    static let email = "Email"
    static let password = "Password"
    static let login = "Login"
    static let signup = "Don't have an account? Sign up"
    static let forgotPassword = "Forgot or First Time? Set Password"
    static let resetPasswordTitle = "Reset Password"
    static let resetPasswordInfo = "We’ll send a link to reset your password if your email is registered."
    static let cancel = "Cancel"
    static let submit = "Submit"
    static let defaultPlaceholder = "Please enter value here"
    static let home = "Home"
    static let settings = "Settings"
    static let entry = "Entry"
}

// MARK: - ErrorMessages
struct ErrorMessages {
    struct Validation {
        static let emailRequired = "Email is required."
        static let invalidEmail = "Please enter a valid email."
        static let passwordRequired = "Password is required."
    }

    struct Auth {
        static let invalidEmail = "Please enter a valid email."
        static let weakPassword = "The password is too weak."
        static let incorrectPassword = "The password is incorrect."
        static let accountNotFound = "No account found for this email."
        static let duplicateAccount = "An account with this email already exists."
    }
}


// MARK: - LandingScreenStrings.swift
struct LandingScreenStrings {
    static let welcomeBack = "Welcome Back"
    static let instruction = "Please enter your credentials to login"
}

// MARK: - AppAssets.swift
struct AppAssets {
    // SF Symbols
    static let loginIcon = "lock.shield.fill"
    static let eyeIcon = "eye"
    static let eyeSlashIcon = "eye.slash"
    static let house = "house"
    static let gear = "gearshape"
    static let rectangle = "plus.rectangle.on.rectangle"
}
