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
    static let ok = "OK"
    static let goToSettings = "Go to Settings"
}

// MARK: - KeyChainKeys
struct KeychainKeys {
    static let userEmail = "com.greatergoods.auth.userEmail"
    static let userPassword = "com.greatergoods.auth.userPassword"
}


// MARK: Alert Messages
struct AlertStrings {
    struct Logout {
        static let title = "Are you sure you want to logout?"
    }
    
    struct ResetPassword {
        static let title = "Reset Password"
        static let message = "We’ll send a link to reset your password if your email is registered."
    }
    
    struct Biometric {
        static let errorTitle = "Biometric Error"
        static let deniedTitle = "Biometric Access Denied"
        static let deniedMessage = "You denied biometrics access to the app. If you want to enable it, go to Settings and allow Face ID or Touch ID access."
        static let savePromptTitle = "Save Credentials?"
        static let savePromptMessage = "Would you like to enable Face ID / Touch ID login next time by securely saving your credentials?"
    }
}

// MARK: - Loader Messages
struct LoaderStrings {
    static let loading = "Loading..."
    static let saving = "Saving..."
    static let deleting = "Deleting..."
    static let loggingIn = "Logging in..."
    static let uploading = "Uploading..."
    static let sending = "Sending..."
    static let updating = "Updating..."
}

// MARK: - Toast Messages
struct ToastStrings {
    static let loading = "Loading..."
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
        
        // New biometric + credential messages
        static let biometricAccessDenied = "You denied biometrics access to the app. If you want to enable it, go to Settings > ModalViewLearningArc and enable biometrics."
        static let noFaceIdEnrolled = "No Face ID is enrolled. Please add a face in Settings to use biometric login."
        static let noFingerprintEnrolled = "No fingerprints are enrolled. Please add a fingerprint in Settings to use biometric login."
        static let biometricVerificationFailed = "Biometric authentication failed. Your face or fingerprint could not be verified."
        static let credentialsNotSaved = "Your credentials haven't been saved. Would you like to save them after a successful login?"
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
    static let addEntry = "Add Entry"
    static func entryTitle(_ isEdit: Bool) -> String {
        return isEdit ? "Edit Entry" : "Create Entry"
    }
    static func sheetTitle(_ isCategory: Bool) -> String {
        return isCategory ? "Select Category" : "Select Tags"
    }
    static let entryDetails = "Entry Details"
    static let noEntriesAvailable = "No entries available"
    static let addPlus = "Add +"
    static let chooseFiles = "Choose Files"
    static let fromPhotos = "From Photos"
    static let openCamera = "Open Camera"
    static let selectedImages = "Selected Images:"
    static let billNotAttached = "Bill not attached"
    static let bills = "Bills"
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
    static let lineDecrease = "line.3.horizontal.decrease"
    static let photo = "photo"
    static let pencil = "pencil"
    static let photoWithExclamationMark = "photo.badge.exclamationmark"
    static let xmarkCircle = "xmark.circle.fill"
    static let faceId = "faceid"
    static let fingerprint = "touchid"
    static let squareAndArrow = "square.and.arrow.up"
}
