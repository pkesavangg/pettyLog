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
    @State private var lastSelectedDate: Date?

    var selectedEntry: MonthlyExpense? {
        guard let date = lastSelectedDate else { return nil }
        return monthlyExpenses.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Expenses")
                .font(.system(size: 16, weight: .medium))
            Chart {
                if let selectedEntry {
                    RuleMark(
                        x: .value("Selected Date", selectedEntry.date)
                    )
                    .foregroundStyle(.purple.opacity(0.2))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        VStack(alignment: .leading, spacing: 10) {
                            // Date Header
                            HStack(spacing: 6) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 10, weight: .bold))
                                Text(selectedEntry.date, format: .dateTime.month().day().year())
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }

                            Divider().background(Color.white.opacity(0.4))

                            // Expense Entry
                            HStack(spacing: 6) {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.red)
                                Text("Amount: $\(selectedEntry.amount, specifier: "%.2f")")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.purple.opacity(0.9), .indigo.opacity(0.85)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                        )
                        .frame(width: 180)
                    }
                }
                
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
            // Enable selection interaction
            .chartXSelection(value: $selectedDate.animation(.easeInOut))
            .onChange(of: selectedDate) { newValue in
                if let newValue {
                    lastSelectedDate = newValue
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
