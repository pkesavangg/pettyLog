//
//  PaletteColor.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//

import SwiftUI

struct PaletteColor: Codable, Identifiable {
    let id: String
    let name: String
    
    var color: Color {
        return Color(UIColor(hex: id) ?? .clear)
    }
    
    static var defaultColor: String {
        return PaletteColor.all.first?.id ?? "#0B6623"
    }
    
    static let all: [PaletteColor] = [
        PaletteColor(id: "#0B6623", name: "Green"),
        PaletteColor(id: "#B8E0E5", name: "Aqua"),
        PaletteColor(id: "#B2C8E0", name: "Blue Gray"),
        PaletteColor(id: "#F7E7B3", name: "Buttercream"),
        PaletteColor(id: "#FE7968", name: "Coral"),
        PaletteColor(id: "#E2E2E2", name: "Gray"),
        PaletteColor(id: "#E6D9F7", name: "Lavender"),
        PaletteColor(id: "#7EBE5E", name: "Lime"),
        PaletteColor(id: "#FB6EF1", name: "Magenta"),
        PaletteColor(id: "#A8E9D1", name: "Mint"),
        PaletteColor(id: "#FFD1A1", name: "Peach"),
        PaletteColor(id: "#87A8EB", name: "Periwinkle"),
        PaletteColor(id: "#FAD1D1", name: "Pink"),
        PaletteColor(id: "#B991F2", name: "Purple"),
        PaletteColor(id: "#C5E2C4", name: "Sage"),
        PaletteColor(id: "#D6BCAB", name: "Sand"),
        PaletteColor(id: "#94DDFE", name: "Sky Blue"),
        PaletteColor(id: "#FF9549", name: "Tangerine"),
        PaletteColor(id: "#FEE250", name: "Yellow")
    ]
}
