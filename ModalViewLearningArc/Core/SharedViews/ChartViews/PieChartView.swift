//
//  PieChartView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 10/05/25.
//
import SwiftUI
import Charts

struct PieChartView: View {
    let categoryExpenses: [CategoryExpense]

    var body: some View {
        Chart(categoryExpenses) { category in
            SectorMark(
                angle: .value(
                    Text(verbatim: category.categoryName),
                    category.percentage
                )
            )
            .foregroundStyle(category.color)
            .cornerRadius(5) // Adds a small gap between slices
            .annotation(position: .overlay) {
                if category.percentage >= 10 { // Only show labels for slices that are large enough
                    Text("\(Int(category.percentage))%")
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
        }
        .chartLegend(.hidden) // Hide the legend as we show it separately below
    }
}
