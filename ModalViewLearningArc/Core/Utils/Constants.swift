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
    static let tags = "Tags"
    static let entry = "Entry"
    static let yes = "Yes"
    static let update = "Update"
    static let theme = "Theme"
    static let done = "Done"
    static let selectColor = "Select Color"
    static let date = "Date"
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
        static let emptyField = "This field cannot be empty."
        static let mustBeAtLeast6Characters = "Must be less than 15 characters"
        static func minLength(_ length: Int = 6) -> String {
            return "Must be at least \(length) characters"
        }
        static func maxLength(_ length: Int = 6) -> String {
            return "Must be less than \(length) characters"
        }
        static let mustBeNumber = "Amount must be a number"
        static let mustBePositive = "Amount must be a positive number"
        static let cantExceedMaxValue = "Amount cannot exceed 30,000"
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

// MARK: - EntryScreenStrings.swift
struct EntryScreenStrings {
    static let title = "Entries"
    static let amountFieldLabel = "Amount"
    static let amountFieldPlaceholder = "Enter amount"
    static let descriptionFieldLabel = "Description"
    static let descriptionFieldPlaceholder = "Enter description"
    static let dateFieldLabel = "Date"
    static let categoryFieldLabel = "Category"
    static let tagFieldLabel = "Tags"
    static func entryTitle(_ isEdit: Bool) -> String {
        return isEdit ? "Edit Entry" : "Create Entry"
    }
    static func sheetTitle(_ isCategory: Bool) -> String {
        return isCategory ? "Select Category" : "Select Tags"
    }
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
    static let categoryFieldPlaceholder = "Enter category name"
    static func categoryTitle(isEdit: Bool) -> String {
        return isEdit ? "Edit Category" : "Create Category"
    }
}

// MARK: - TagScreenStrings.swift
struct TagScreenStrings {
    static let title = "Tags"
    static let createNewTag = "Create New Tag"
    static let tagFieldPlaceholder = "Enter tag name"
    static func tagTitle(isEdit: Bool) -> String {
        return isEdit ? "Edit Tag" : "Create Tag"
    }
    static let emptyTagList = "No tags available"
}

// MARK: - ThemeScreenStrings.swift
struct ThemeScreenStrings {
    static let title = "Themes"
    static let themeColor = "Theme Color"
    static let appearance = "Appearance"
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
    static let trash = "trash"
    static let checkmark = "checkmark"
}
