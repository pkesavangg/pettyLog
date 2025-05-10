//
//  CategoryExpense.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 10/05/25.
//


import SwiftUI
import Charts

struct CategoryExpense: Identifiable {
    let id = UUID()
    let categoryId: String
    let categoryName: String
    let amount: Double
    let color: Color
    let percentage: Double
}