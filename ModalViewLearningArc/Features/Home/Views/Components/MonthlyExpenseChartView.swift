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
        VStack(alignment: .leading, spacing: 16) {
            Text("Monthly Expense Trends")
                .font(.headline)
                .foregroundColor(theme.onSurface)

            if monthlyExpenses.isEmpty {
                Text("No expense data available")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(theme.onSurface.opacity(0.7))
            } else {
                chartView
                   // .frame(height: 250)
            }
        }
        .padding()
        .background(theme.surface)
        .cornerRadius(12)
        .shadow(color: theme.onSurface.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private var chartView: some View {
        VStack(spacing: 0) {
            // Chart title
            Text("Monthly Expense Trends")
                .font(.headline)
                .foregroundColor(theme.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
                .zIndex(1) // Ensure title stays on top

            // Chart container
            ZStack(alignment: .top) {
                // The actual chart
                Chart {
                    // Plot the line for monthly expenses
                    ForEach(monthlyExpenses) { expense in
                        LineMark(
                            x: .value("Month", expense.date),
                            y: .value("Amount", expense.amount)
                        )
                        .foregroundStyle(theme.primary)
                        .interpolationMethod(.catmullRom)
                    }

                    // Add points for each month
                    ForEach(monthlyExpenses) { expense in
                        PointMark(
                            x: .value("Month", expense.date),
                            y: .value("Amount", expense.amount)
                        )
                        .foregroundStyle(theme.primary)
                    }

                    // Add average line
                    RuleMark(y: .value("Average", averageExpense))
                        .foregroundStyle(theme.secondary.opacity(0.7))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                        .annotation(position: .top, alignment: .trailing) {
                            Text("Avg: ₹\(String(format: "%.0f", averageExpense))")
                                .font(.caption)
                                .foregroundColor(theme.secondary)
                        }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel {
                                Text(date.formattedMonthYear())
                                    .font(.caption2)
                                    .foregroundColor(theme.onSurface.opacity(0.7))
                            }
                            AxisGridLine()
                            AxisTick()
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            if let amount = value.as(Double.self) {
                                Text("₹\(String(format: "%.0f", amount))")
                                    .font(.caption2)
                                    .foregroundColor(theme.onSurface.opacity(0.7))
                            }
                        }
                        AxisGridLine()
                        AxisTick()
                    }
                }
               // .frame(height: 200)
                .padding(.bottom, 10)

                // Selection overlay
                if let selectedMonth = selectedMonth {
                    GeometryReader { geo in
                        // Calculate position based on the selected month
                        let dateRange = monthlyExpenses.map { $0.date }
                        let minDate = dateRange.min() ?? Date()
                        let maxDate = dateRange.max() ?? Date()
                        let totalDays = maxDate.timeIntervalSince(minDate)
                        let daysFromStart = selectedMonth.date.timeIntervalSince(minDate)
                        let position = totalDays > 0 ? daysFromStart / totalDays : 0

                        // Position the vertical line
                        Rectangle()
                            .fill(theme.onSurface.opacity(0.3))
                            .frame(width: 1)
                            .frame(maxHeight: 200)
                            .position(x: geo.size.width * CGFloat(position), y: 100)

                        // Position the tooltip
                        VStack(alignment: .leading, spacing: 4) {
                            Text(selectedMonth.monthYear)
                                .font(.caption)
                                .foregroundColor(theme.onSurface)

                            Text("₹\(String(format: "%.2f", selectedMonth.amount))")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(theme.primary)

                            Text("\(selectedMonth.entriesCount) entries")
                                .font(.caption2)
                                .foregroundColor(theme.onSurface.opacity(0.7))
                        }
                        .padding(8)
                        .background(theme.surface)
                        .cornerRadius(8)
                        .shadow(color: theme.onSurface.opacity(0.1), radius: 2, x: 0, y: 1)
                        .position(
                            x: min(max(geo.size.width * CGFloat(position), 80), geo.size.width - 80),
                            y: 50
                        )
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(theme.surface.opacity(0.3))
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        // Find the closest month based on horizontal position
                        let width = value.location.x
                        let totalWidth = value.startLocation.x + value.translation.width
                        let percentage = width / totalWidth

                        // Sort months chronologically
                        let sortedMonths = monthlyExpenses.sorted { $0.date < $1.date }

                        // Calculate index based on percentage
                        let index = Int(percentage * Double(sortedMonths.count))
                        let safeIndex = max(0, min(index, sortedMonths.count - 1))

                        // Set selected month
                        selectedMonth = sortedMonths[safeIndex]
                    }
            )
        }
        .padding(.horizontal)
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
