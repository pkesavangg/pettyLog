//
//  PieChartView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
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

#Preview {
    PieChartView(
        categoryExpenses: [
            CategoryExpense(categoryId: "groceries", categoryName: "Groceries", amount: 500, color: .green, percentage: 50),
            CategoryExpense(categoryId: "eating_out", categoryName: "Eating Out", amount: 300, color: .blue, percentage: 30),
            CategoryExpense(categoryId: "transport", categoryName: "Transport", amount: 200, color: .orange, percentage: 20)
        ]
    )
    .frame(height: 250)
    .padding()
}
