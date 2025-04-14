//
//  EmailStepView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


// MARK: - EmailStepView.swift
import SwiftUI

struct EmailStepView: View {
    @Bindable var viewModel: SignupFlowViewModel
    let authModel: AuthAggregateModel

    var body: some View {
        VStack {
            Spacer(minLength: 40)

            VStack(spacing: 16) {
                Image(systemName: "envelope.badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.blue)

                Text("Almost There")
                    .font(.title.bold())

                Text("Enter your email and password to complete signup")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Group {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                }

                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                HStack(spacing: 12) {
                    Button {
                        viewModel.goToPreviousStep()
                    } label: {
                        Text("Back")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Button {
                        Task {
                            await viewModel.signup(using: authModel)
                        }
                    } label: {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background((viewModel.email.isEmpty || viewModel.password.isEmpty) ? Color.gray.opacity(0.3) : Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.thinMaterial)
                    .shadow(radius: 10)
            )
            .padding(.horizontal)

            Spacer()
        }
        .background(
            LinearGradient(colors: [.blue.opacity(0.2), .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

#Preview("Step 2 - Email + Password") {
    EmailStepView(viewModel: {
        let vm = SignupFlowViewModel()
        vm.firstName = "Test"
        vm.lastName = "User"
        vm.goToNextStep()
        return vm
    }(), authModel: AuthAggregateModel())
}

