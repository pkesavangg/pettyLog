//
//  AlertManager.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation
import SwiftUI

// Define alert types
enum AlertType {
    case standard        // Simple alert with title, message, and buttons
    case inputField      // Alert with an input field
    case confirmation    // Alert for confirming actions
}

// Define button types
enum AlertButtonType {
    case primary
    case secondary
    case cancel
    case destructive
}

// Define button configuration
struct AlertButton {
    let title: String
    let type: AlertButtonType
    let action: () -> Void
    
    init(title: String, type: AlertButtonType = .primary, action: @escaping () -> Void = {}) {
        self.title = title
        self.type = type
        self.action = action
    }
}

// Define input field configuration
struct AlertInputField {
    var text: String = ""
    let placeholder: String
    let keyboardType: UIKeyboardType
    let autocapitalization: TextInputAutocapitalization
    let disableAutocorrection: Bool
    
    init(
        text: String = "",
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        disableAutocorrection: Bool = false
    ) {
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.disableAutocorrection = disableAutocorrection
    }
}

@Observable
@MainActor
final class AlertManager {
    static let shared = AlertManager()
    
    // Alert state
    var isPresented: Bool = false
    var title: String = ""
    var message: String = ""
    var alertType: AlertType = .standard
    
    // Buttons
    var primaryButton: AlertButton?
    var secondaryButton: AlertButton?
    
    // Input field (for inputField type)
    var inputField: AlertInputField?
    
    private init() {}
    
    // Show a standard alert
    func showAlert(
        title: String,
        message: String,
        primaryButton: AlertButton? = nil,
        secondaryButton: AlertButton? = nil
    ) {
        self.title = title
        self.message = message
        self.alertType = .standard
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.isPresented = true
    }
    
    // Show an alert with an input field
    func showInputAlert(
        title: String,
        message: String,
        inputField: AlertInputField,
        primaryButton: AlertButton? = nil,
        secondaryButton: AlertButton? = nil
    ) {
        self.title = title
        self.message = message
        self.alertType = .inputField
        self.inputField = inputField
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.isPresented = true
    }
    
    // Show a confirmation alert
    func showConfirmation(
        title: String,
        message: String,
        primaryButton: AlertButton,
        secondaryButton: AlertButton? = nil
    ) {
        self.title = title
        self.message = message
        self.alertType = .confirmation
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.isPresented = true
    }
    
    // Dismiss the alert
    func dismiss() {
        isPresented = false
        // Reset values after a short delay to allow animations to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.resetValues()
        }
    }
    
    // Reset all values
    private func resetValues() {
        title = ""
        message = ""
        alertType = .standard
        primaryButton = nil
        secondaryButton = nil
        inputField = nil
    }
}
