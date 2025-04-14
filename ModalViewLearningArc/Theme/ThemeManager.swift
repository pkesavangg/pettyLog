//
//  ThemeManager.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @Published var currentColorScheme: ColorScheme = .blue
    @Published var isDarkMode: Bool = false
    
    private init() {}
}
