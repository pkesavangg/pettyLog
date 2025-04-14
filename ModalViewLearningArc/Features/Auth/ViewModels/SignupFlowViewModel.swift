//
//  SignupFlowViewModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


// MARK: - Signup Flow ViewModel
import Foundation

@Observable
@MainActor
class SignupFlowViewModel {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var step: Int = 0
    var error: String?
    var isComplete: Bool = false

    func goToNextStep() {
        step += 1
    }

    func goToPreviousStep() {
        step -= 1
    }

    func signup(using store: AuthAggregateModel) async {
        guard isValid() else { return }

        do {
            try await store.signup(email: email, password: password, firstName: firstName, lastName: lastName)
            isComplete = true
        } catch {
            self.error = error.localizedDescription
        }
    }

    private func isValid() -> Bool {
        if email.isEmpty || password.isEmpty {
            error = "Email and password are required."
            return false
        }
        if password.count < 6 {
            error = "Password must be at least 6 characters long."
            return false
        }
        return true
    }
}
