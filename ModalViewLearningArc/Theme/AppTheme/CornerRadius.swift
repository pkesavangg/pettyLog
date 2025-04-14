//
//  CornerRadiusSize.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//
import SwiftUI

enum CornerRadiusSize {
    case xsmall, small, medium, large, xlarge

    var value: CGFloat {
        switch self {
        case .xsmall: return 4
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        case .xlarge: return 24
        }
    }
}

extension View {
    func cornerRadius(_ size: CornerRadiusSize) -> some View {
        self.cornerRadius(size.value)
    }
}


