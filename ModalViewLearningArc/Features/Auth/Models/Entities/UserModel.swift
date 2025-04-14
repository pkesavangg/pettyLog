//
//  UserModel.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import Foundation
import SwiftData

@Model
class UserModel {
    var id: UUID = UUID()
    var uid: String                  // ✅ Add this line
    var email: String
    var firstName: String
    var lastName: String
    var createdAt: Date
    var isLoggedIn: Bool = false

    init(uid: String, email: String, firstName: String, lastName: String, createdAt: Date = .now, isLoggedIn: Bool = false) {
        self.uid = uid              // ✅ Set uid here
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        self.isLoggedIn = isLoggedIn
    }
}

