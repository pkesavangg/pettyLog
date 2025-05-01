//
//  TagChipView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//


import SwiftUI

struct TagChipView: View {
    @Environment(\.appTheme) private var theme
    let tag: TagModel

    var body: some View {
        Text(tag.name)
            .font(.caption)
            .padding(.horizontal, .p12)
            .padding(.vertical, .p6)
            .background(tag.displayColor)
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}