//
//  ToastManager.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import Foundation
import SwiftUI

@Observable
@MainActor
final class ToastManager {
    static let shared = ToastManager()
    
    var message: String = ""
    var isVisible: Bool = false

    func show(_ message: String, duration: TimeInterval = 2.0) {
        self.message = message
        self.isVisible = true

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isVisible = false
            self.message = ""
        }
    }
}
