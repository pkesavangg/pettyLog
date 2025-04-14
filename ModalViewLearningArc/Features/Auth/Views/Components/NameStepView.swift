//
//  NameStepView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


// MARK: - NameStepView.swift
import SwiftUI

struct NameStepView: View {
    @Bindable var viewModel: SignupFlowViewModel

    var body: some View {
        VStack {
            Spacer(minLength: 40)

            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.blue)

                Text("Create Account")
                    .font(.title.bold())

                Text("Let’s start with your name")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                VStack(spacing: 12) {
                    TextField("First Name", text: $viewModel.firstName)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.words)

                    TextField("Last Name", text: $viewModel.lastName)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.words)
                }

                Button {
                    viewModel.goToNextStep()
                } label: {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(viewModel.firstName.isEmpty || viewModel.lastName.isEmpty ? Color.gray.opacity(0.3) : Color.accentColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(viewModel.firstName.isEmpty || viewModel.lastName.isEmpty)
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

#Preview("Step 1 - Name") {
    NameStepView(viewModel: SignupFlowViewModel())
        .environment(AuthAggregateModel())
}

