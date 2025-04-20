//
//  CustomTextField.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import SwiftUI

/// A customizable text field with outlined styling and built-in input type handling.
/// Supports password visibility toggle (`.passwordWithToggle`), keyboard configuration, and capitalization settings.
struct CustomTextField: View {
    @Environment(\.appTheme) private var theme
    @Binding var value: String
    var placeholder: String = CommonStrings.defaultPlaceholder
    var inputType: InputType = .text
    var label: String = ""
    @State private var isSecure: Bool = true
    var isDirty: Binding<Bool>? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            if !label.isEmpty {
                Text(label)
                    .labelStyle()
            }
            HStack {
                // MARK: - Field type rendering
                Group {
                    switch inputType {
                    case .password:
                        SecureField(placeholder, text: $value)
                            .textStyle

                    case .passwordWithToggle:
                        if isSecure {
                            SecureField(placeholder, text: $value)
                                .textStyle
                        } else {
                            TextField(placeholder, text: $value)
                                .keyboardType(keyboardType)
                                .textInputAutocapitalization(autocapitalization)
                                .textStyle
                        }

                    default:
                        TextField(placeholder, text: $value)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(autocapitalization)
                            .textStyle
                    }
                }
                .frame(height: 25)

                // MARK: - Toggle button for passwordWithToggle
                if inputType == .passwordWithToggle {
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? AppAssets.eyeIcon : AppAssets.eyeSlashIcon)
                            .foregroundColor(theme.onSurface.opacity(0.6))
                    }
                }
            }
            .onChange(of: value) {
                if let isDirty = isDirty, !isDirty.wrappedValue {
                    isDirty.wrappedValue = true
                }
            }
            .padding(.all, .p12)
            .background(theme.surface)
            .cornerRadius(.small)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(theme.onSurface.opacity(0.2), lineWidth: 1)
            }
        }
    }

    /// Determines keyboard type based on input type
    private var keyboardType: UIKeyboardType {
        switch inputType {
        case .email:
            return .emailAddress
        case .number:
            return .numberPad
        case .phoneNumber:
            return .phonePad
        default:
            return .default
        }
    }

    /// Controls autocapitalization behavior based on input type
    private var autocapitalization: TextInputAutocapitalization {
        switch inputType {
        case .email, .password, .passwordWithToggle:
            return .never
        default:
            return .sentences
        }
    }
}

private extension View {
    var textStyle: some View {
        self
            .foregroundColor(Color.primary) // Or theme.onSurface if dynamic
            .font(.body)
    }
}


#Preview("CustomTextField Variants") {
    VStack(spacing: 16) {
        CustomTextField(value: .constant("user@example.com"), placeholder: "Email", inputType: .email, label: "Email Address")

        CustomTextField(value: .constant(""), placeholder: "Phone", inputType: .phoneNumber)

        CustomTextField(value: .constant("123456"), placeholder: "Password", inputType: .password)

        CustomTextField(value: .constant("Secret123"), placeholder: "Password with Toggle", inputType: .passwordWithToggle)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

