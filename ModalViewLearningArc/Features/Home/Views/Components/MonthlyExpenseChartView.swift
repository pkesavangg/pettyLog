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
    @State private var selectedDate: Date?

    var selectedEntry: MonthlyExpense? {
        guard let selectedDate else { return nil }
        return monthlyExpenses.first { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Expenses")
                .font(.system(size: 16, weight: .medium))

            Chart {
                // Expense lines and points
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
                    .symbol {
                        Circle()
                            .fill(theme.primary)
                            .frame(width: 8, height: 8)
                    }
                }

                // Average rule
                RuleMark(y: .value("Average", averageExpense))
                    .foregroundStyle(Color.orange)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    .annotation(position: .automatic, alignment: .leading) {
                        Text("Avg: \(averageExpense, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
            }
            .chartXAxis {
                AxisMarks(values: monthlyExpenses.map { $0.date }) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel {
                            Text(date, format: .dateTime.month(.abbreviated))
                                .font(.footnote)
                        }
                        AxisTick()
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
        }
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
