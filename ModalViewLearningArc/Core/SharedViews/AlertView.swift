//
//  AlertView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct AlertView: View {
    @Environment(AlertManager.self) var alertManager
    @Environment(\.appTheme) private var theme
    
    // For input field binding
    @State private var inputText: String = ""
    
    var body: some View {
        if alertManager.isPresented {
            ZStack {
                // Semi-transparent background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Optional: dismiss on background tap
                        // alertManager.dismiss()
                    }
                
                // Alert container
                VStack(spacing: 16) {
                    // Title
                    Text(alertManager.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(theme.onSurface)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    // Message
                    if !alertManager.message.isEmpty {
                        Text(alertManager.message)
                            .font(.subheadline)
                            .foregroundColor(theme.onSurface.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Input field (if applicable)
                    if alertManager.alertType == .inputField, let inputField = alertManager.inputField {
                        VStack(alignment: .leading, spacing: 4) {
                            TextField(inputField.placeholder, text: $inputText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(inputField.keyboardType)
//                                .autocapitalization(inputField.autocapitalization)
                                .disableAutocorrection(inputField.disableAutocorrection)
                                .padding(.horizontal)
                                .onAppear {
                                    inputText = inputField.text
                                }
                                .onChange(of: inputText) { _, newValue in
                                    alertManager.inputField?.text = newValue
                                }
                        }
                    }
                    
                    // Buttons
                    HStack(spacing: 8) {
                        // Secondary button (if present)
                        if let secondaryButton = alertManager.secondaryButton {
                            Button {
                                let action = secondaryButton.action
                                alertManager.dismiss()
                                action()
                            } label: {
                                Text(secondaryButton.title)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                            }
                            .buttonStyle(AlertButtonStyle(type: secondaryButton.type, theme: theme))
                        }
                        
                        // Primary button (if present)
                        if let primaryButton = alertManager.primaryButton {
                            Button {
                                let action = primaryButton.action
                                alertManager.dismiss()
                                action()
                            } label: {
                                Text(primaryButton.title)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                            }
                            .buttonStyle(AlertButtonStyle(type: primaryButton.type, theme: theme))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                }
                .frame(width: min(UIScreen.main.bounds.width - 50, 300))
                .background(theme.surface)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut(duration: 0.2), value: alertManager.isPresented)
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.2), value: alertManager.isPresented)
        }
    }
}

// Custom button style for alert buttons
struct AlertButtonStyle: ButtonStyle {
    let type: AlertButtonType
    let theme: AppColors.Palette
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .foregroundColor(foregroundColor(for: type))
            .background(backgroundColor(for: type))
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
    
    private func backgroundColor(for type: AlertButtonType) -> Color {
        switch type {
        case .primary:
            return theme.primary
        case .secondary:
            return Color.gray.opacity(0.2)
        case .cancel:
            return Color.gray.opacity(0.2)
        case .destructive:
            return theme.error
        }
    }
    
    private func foregroundColor(for type: AlertButtonType) -> Color {
        switch type {
        case .primary:
            return theme.onPrimary
        case .secondary, .cancel:
            return theme.onSurface
        case .destructive:
            return theme.onError
        }
    }
}

//#Preview {
//    let alertManager = AlertManager.shared
//    
//    // Simulate showing an alert
//    alertManager.showInputAlert(
//        title: "Reset Password",
//        message: "We'll send a link to reset your password if your email is registered.",
//        inputField: AlertInputField(
//            placeholder: "Email",
//            keyboardType: .emailAddress,
//            autocapitalization: .never,
//            disableAutocorrection: true
//        ),
//        primaryButton: AlertButton(title: "Submit", action: {
//            print("Submit tapped with input: \(alertManager.inputField?.text ?? "")")
//        }),
//        secondaryButton: AlertButton(title: "Cancel", type: .cancel, action: {
//            print("Cancel tapped")
//        })
//    )
//    
//    ZStack {
//        Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
//        Text("Content behind alert")
//        AlertView()
//    }
//    .environment(alertManager)
//    .environmentObject(ThemeManager.shared)
//    .themeable()
//}
