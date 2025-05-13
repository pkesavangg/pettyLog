//
//  MonthlyExpenseChartView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI
import Charts

struct MonthlyExpenseChartView: View {
    let monthlyExpenses: [MonthlyExpense]
    let averageExpense: Double
    
    @Environment(\.appTheme) private var theme
    @State private var selectedMonth: MonthlyExpense?
    @State private var plotWidth: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Expenses")
                .font(.system(size: 16, weight: .medium))
            
            Chart {
                // Line and points for each month's expense
                ForEach(monthlyExpenses) { item in
                    LineMark(
                        x: .value("Month", item.date),
                        y: .value("Amount", item.amount)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(theme.primary)
                    .lineStyle(.init(lineWidth: 2))
                    
                    PointMark(
                        x: .value("Month", item.date),
                        y: .value("Amount", item.amount)
                    )
                    .foregroundStyle(.blue)
                    .symbol {
                        Circle()
                            .fill(theme.primary)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisValueLabel(format: .dateTime.month(.abbreviated))
                }
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading)
            }        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    MonthlyExpenseChartView(
        monthlyExpenses: HomeAggregateModel.withSampleData().monthlyExpenses,
        averageExpense: 3000
    )
    .padding()
    .background(Color(.systemBackground))
}
