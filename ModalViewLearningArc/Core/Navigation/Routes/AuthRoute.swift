//
//  LandingRoute.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//
import SwiftUI

enum AuthRoute: Routable {
    case login
    case signup
    
    var body: some View {
        switch self {
        case .login:
            LoginScreen()
        case .signup:
            SignupScreen()
        }
    }
}
