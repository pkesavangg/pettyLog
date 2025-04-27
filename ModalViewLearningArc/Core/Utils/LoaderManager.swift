//
//  LoaderManager.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class LoaderManager {
    static let shared = LoaderManager()
    
    var message: String = LoaderStrings.loading
    var isVisible: Bool = false
    
    private init() {}
    
    func show(message: String = LoaderStrings.loading) {
        self.message = message
        self.isVisible = true
    }
    
    func hide() {
        self.isVisible = false
        self.message = LoaderStrings.loading // Reset to default message
    }
}
