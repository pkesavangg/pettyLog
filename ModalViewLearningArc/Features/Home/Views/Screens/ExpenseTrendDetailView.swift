//
//  ExpenseTrendDetailView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI
import Charts

struct ExpenseTrendDetailView: View {
    let monthlyExpenses: [MonthlyExpense]
    let averageExpense: Double

    @Environment(\.appTheme) private var theme
    @Environment(\.dismiss) private var dismiss

    @State private var selectedMonth: MonthlyExpense?
    @State private var showMonthToMonthChange: Bool = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Main chart
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
                            detailedChartView
                                .frame(height: 300)
                        }
                    }
                    .padding()
                    .background(theme.surface)
                    .cornerRadius(12)

                    // Analytics section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Analytics")
                            .font(.headline)
                            .foregroundColor(theme.onSurface)

                        // Average expense
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Average Monthly Expense")
                                    .font(.subheadline)
                                    .foregroundColor(theme.onSurface)

                                Text("₹\(String(format: "%.2f", averageExpense))")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(theme.primary)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(theme.surface.opacity(0.5))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(theme.onSurface.opacity(0.1), lineWidth: 1)
                        )

                        // Month-to-month changes toggle
                        Toggle(isOn: $showMonthToMonthChange) {
                            Text("Show Month-to-Month Changes")
                                .font(.subheadline)
                                .foregroundColor(theme.onSurface)
                        }
                        .padding(.vertical, 8)

                        // Month-to-month percentage changes
                        if showMonthToMonthChange && monthlyExpenses.count > 1 {
                            monthToMonthChangesView
                        }
                    }
                    .padding()
                    .background(theme.surface)
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Expense Trends")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(theme.primary)
                    }
                }
            }
        }
    }

    private var detailedChartView: some View {
        VStack(spacing: 0) {
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
                .frame(height: 250)
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
                            .frame(maxHeight: 250)
                            .position(x: geo.size.width * CGFloat(position), y: 125)

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
    }

    private var monthToMonthChangesView: some View {
        VStack(spacing: 12) {
            ForEach(0..<monthlyExpenses.count-1, id: \.self) { index in
                if index + 1 < monthlyExpenses.count {
                    let currentMonth = monthlyExpenses[index + 1]
                    let previousMonth = monthlyExpenses[index]

                    if let percentChange = currentMonth.percentageChange(from: previousMonth) {
                        HStack {
                            Text("\(previousMonth.shortMonthYear) → \(currentMonth.shortMonthYear)")
                                .font(.subheadline)
                                .foregroundColor(theme.onSurface)

                            Spacer()

                            HStack(spacing: 4) {
                                Image(systemName: percentChange >= 0 ? "arrow.up" : "arrow.down")
                                    .font(.caption)
                                    .foregroundColor(percentChange >= 0 ? .red : .green)

                                Text("\(String(format: "%.1f", abs(percentChange)))%")
                                    .font(.subheadline)
                                    .foregroundColor(percentChange >= 0 ? .red : .green)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(theme.surface.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
}

#Preview {
    ExpenseTrendDetailView(
        monthlyExpenses: HomeAggregateModel.withSampleData().monthlyExpenses,
        averageExpense: 3000
    )
}
