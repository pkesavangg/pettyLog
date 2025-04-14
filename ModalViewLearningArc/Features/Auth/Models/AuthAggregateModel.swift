//
//  AuthAggregateModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


// MARK: - AuthAggregateModel
import Foundation
import SwiftData
import SwiftUI
import FirebaseAuth

@Observable
@MainActor
final class AuthAggregateModel {
    private let container: ModelContainer
    private let context: ModelContext
    var authState: AuthLoadState = .loading
    
    var currentUser: UserModel?

    init() {
        do {
            container = try ModelContainer(for: UserModel.self)
            context = container.mainContext

            // Load logged-in user (if any)
            Task {
                try await loadLoggedInUser()
            }

        } catch {
            fatalError("❌ Failed to initialize ModelContainer: \(error)")
        }
    }

    // MARK: - Signup
    func signup(email: String, password: String, firstName: String, lastName: String) async throws {
        guard email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            throw AuthError.invalidEmail
        }
        var result: AuthDataResult?
        // ✅ Step 1: Create account with Firebase
        do {
            result = try await Auth.auth().createUser(withEmail: email, password: password)

            guard let result = result else {
                throw AuthError.custom("Failed to create user.")
            }
            
            // Optional: You can also update Firebase display name
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = "\(firstName) \(lastName)"
            try await changeRequest.commitChanges()

        } catch let error as NSError {
            // Handle Firebase-specific errors
            switch AuthErrorCode(rawValue: error.code) {
            case .emailAlreadyInUse:
                throw AuthError.duplicateAccount
            case .invalidEmail:
                throw AuthError.invalidEmail
            case .weakPassword:
                throw AuthError.weakPassword
            default:
                throw AuthError.custom(error.localizedDescription)
            }
        }

        // ✅ Step 2: Save user locally in SwiftData
        let exists = try context.fetchCount(FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.email == email }
        )) > 0

        if exists {
            throw AuthError.duplicateAccount
        }

        try logoutAllUsers() // Optional, ensures one active user

        let user = UserModel(
            uid: result?.user.uid ?? "",
            email: email,
            firstName: firstName,
            lastName: lastName,
            isLoggedIn: true
        )
        context.insert(user)
        try context.save()

        currentUser = user
        authState = .loggedIn
    }
    
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            // Check if local user exists
            let descriptor = FetchDescriptor<UserModel>(
                predicate: #Predicate { $0.email == email }
            )

            let localUser = try context.fetch(descriptor).first

            try logoutAllUsers()
            
            if let user = localUser {
                user.isLoggedIn = true
                try context.save()
                currentUser = user
            } else {
                // Firebase success, but not in SwiftData — create entry
                let user = UserModel(
                    uid: result.user.uid,                 // ✅ Add uid
                    email: result.user.email ?? "",
                    firstName: result.user.displayName ?? "",
                    lastName: "",
                    isLoggedIn: true
                )
                context.insert(user)
                try context.save()
                currentUser = user
            }

            authState = .loggedIn

        } catch let error as NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .userNotFound:
                throw AuthError.accountNotFound
            case .wrongPassword:
                throw AuthError.incorrectPassword
            default:
                throw AuthError.custom(error.localizedDescription)
            }
        }
    }
    
    func sendPasswordReset(to email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }


    // MARK: - Logout
    func logout() throws {
        guard let user = currentUser else { return }
        user.isLoggedIn = false
        try context.save()
        currentUser = nil
        authState = .loggedOut
    }

    // MARK: - Auto load existing login
    private func loadLoggedInUser() async throws {
        authState = .loading
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.isLoggedIn == true }
        )
        currentUser = try context.fetch(descriptor).first
        // Simulate Firebase Signup
        try await Task.sleep(nanoseconds: 1_000_000_000)
        authState = currentUser == nil ? .loggedOut : .loggedIn
    }

    // MARK: - Logout helper
    private func logoutAllUsers() throws {
        let all = try context.fetch(FetchDescriptor<UserModel>())
        for u in all where u.isLoggedIn {
            u.isLoggedIn = false
        }
        try context.save()
        authState = .loggedOut
    }
}

