//
//  PaddingSizeEnum.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import SwiftUI


enum PaddingSizeEnum {
    case p2, p4, p6, p8, p10, p12, p16, p20, p24, p32

    var value: CGFloat {
        switch self {
        case .p2: return 2
        case .p4: return 4
        case .p8: return 8
        case .p6: return 6
        case .p10: return 10
        case .p12: return 12
        case .p16: return 16
        case .p20: return 20
        case .p24: return 24
        case .p32: return 32
        }
    }
}

extension View {
    func padding(_ edges: Edge.Set = .all, _ size: PaddingSizeEnum) -> some View {
        self.padding(edges, size.value)
    }
}

