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
    static let save = "Save"
    static let signup = "Don't have an account? Sign up"
    static let forgotPassword = "Forgot or First Time? Set Password"
    static let resetPasswordTitle = "Reset Password"
    static let resetPasswordInfo = "We’ll send a link to reset your password if your email is registered."
    static let cancel = "Cancel"
    static let submit = "Submit"
    static let defaultPlaceholder = "Please enter value here"
    static let home = "Home"
    static let settings = "Settings"
    static let categories = "Categories"
    static let entry = "Entry"
    static let yes = "Yes"
}

// MARK: Alert Messages
struct AlertMessages {
    struct Logout {
        static let title = "Are you sure you want to logout?"
    }
    
    struct ResetPassword {
        static let title = "Reset Password"
        static let message = "We’ll send a link to reset your password if your email is registered."
    }
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

// MARK: - SettingScreenStrings.swift
struct SettingScreenStrings {
    static let profile = "Profile"
    static let configure = "Configure"
    static let aboutUs = "About Us"
    static let others = "Others"
    static let logout = "Logout"
    static let rateUs = "Rate Us"
}

// MARK: - CategoryScreenStrings.swift
struct CategoryScreenStrings {
    static let title = "Categories"
    static let createNewCategory = "Create New Category"
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
    static let personCrop = "person.crop.circle"
    static let plus = "plus"
    static let chevronRight = "chevron.right"
}
