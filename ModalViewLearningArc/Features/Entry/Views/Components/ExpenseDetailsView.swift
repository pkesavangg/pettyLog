//
//  ExpenseDetailsView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct CategoryExpense: Identifiable {
    let id = UUID()
    let categoryId: String
    let categoryName: String
    let amount: Double
    let color: Color
    let percentage: Double
}

struct ExpenseDetailsView: View {
    let selectedMonth: Date
    let entries: [EntryModel]
    let categories: [CategoryModel]
    let totalAmount: Double

    @Environment(\.appTheme) private var theme
    @Environment(\.dismiss) private var dismiss
    let lang = EntryScreenStrings.self

    private var categoryExpenses: [CategoryExpense] {
        // Group entries by category
        let groupedEntries = Dictionary(grouping: entries) { entry in
            entry.category
        }

        // Calculate total amount per category
        var result: [CategoryExpense] = []

        for (categoryId, entries) in groupedEntries {
            let categoryTotal = entries.reduce(0) { $0 + $1.amount }
            let percentage = totalAmount > 0 ? (categoryTotal / totalAmount) * 100 : 0

            // Find category name
            let categoryName = categories.first(where: { $0.id == categoryId })?.name ?? "Unknown"
            let categoryColor = categories.first(where: { $0.id == categoryId })?.displayColor ?? theme.primary

            result.append(CategoryExpense(
                categoryId: categoryId,
                categoryName: categoryName,
                amount: categoryTotal,
                color: categoryColor,
                percentage: percentage
            ))
        }

        // Sort by amount (highest first)
        return result.sorted(by: { $0.amount > $1.amount })
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) { // Increased spacing between main sections
                    // Month and total
                    HStack {
                        VStack(alignment: .leading) {
                            Text(selectedMonth.formattedMonthYear())
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(theme.onSurface)

                            Text("Total: ₹\(String(format: "%.2f", totalAmount))")
                                .font(.headline)
                                .foregroundColor(theme.onSurface.opacity(0.8))
                        }

                        Spacer()
                    }
                    .padding(.bottom, 16) // Increased bottom padding

                    // Pie chart
                    if !categoryExpenses.isEmpty {
                        PieChartView(categoryExpenses: categoryExpenses)
                            .frame(height: 250)
                            .padding(.vertical, 16) // Increased vertical padding
                    } else {
                        Text(lang.noExpenseData)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .foregroundColor(theme.onSurface.opacity(0.7))
                    }

                    Divider() // Added divider for visual separation
                        .padding(.vertical, 8)

                    // Category breakdown
                    VStack(alignment: .leading, spacing: 12) { // Increased spacing between items
                        Text(lang.categoryBreakdown)
                            .font(.headline)
                            .foregroundColor(theme.onSurface)
                            .padding(.bottom, 4)

                        ForEach(categoryExpenses) { category in
                            HStack {
                                Circle()
                                    .fill(category.color)
                                    .frame(width: 12, height: 12)

                                Text(category.categoryName)
                                    .font(.subheadline)
                                    .foregroundColor(theme.onSurface)

                                Spacer()

                                Text("₹\(String(format: "%.2f", category.amount))")
                                    .font(.subheadline)
                                    .foregroundColor(theme.onSurface)

                                Text("(\(String(format: "%.1f", category.percentage))%)")
                                    .font(.caption)
                                    .foregroundColor(theme.onSurface.opacity(0.7))
                                    .frame(width: 60, alignment: .trailing)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(lang.expenseDetails)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: AppAssets.xmarkCircle)
                            .foregroundColor(theme.primary)
                    }
                }
            }
        }
    }
}

struct PieChartView: View {
    let categoryExpenses: [CategoryExpense]

    var body: some View {
        ZStack {
            ForEach(0..<categoryExpenses.count, id: \.self) { index in
                PieSliceView(
                    startAngle: startAngle(for: index),
                    endAngle: endAngle(for: index),
                    color: categoryExpenses[index].color
                )
            }

            // No center circle - removed as requested
        }
    }

    private func startAngle(for index: Int) -> Double {
        if index == 0 {
            return 0
        }

        let previousSlices = categoryExpenses[0..<index]
        let previousTotal = previousSlices.reduce(0) { $0 + $1.percentage }
        return previousTotal * 3.6 // Convert percentage to degrees (360 / 100 = 3.6)
    }

    private func endAngle(for index: Int) -> Double {
        let previousSlices = categoryExpenses[0...index]
        let previousTotal = previousSlices.reduce(0) { $0 + $1.percentage }
        return previousTotal * 3.6 // Convert percentage to degrees
    }
}

struct PieSliceView: View {
    let startAngle: Double
    let endAngle: Double
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                let radius = min(geometry.size.width, geometry.size.height) / 2

                // Add a small gap between slices by reducing the arc slightly
                let gapAngle = 2.0 // 2 degree gap
                let adjustedStartAngle = startAngle + (gapAngle / 2)
                let adjustedEndAngle = endAngle - (gapAngle / 2)

                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(adjustedStartAngle - 90), // -90 to start from top
                    endAngle: .degrees(adjustedEndAngle - 90),
                    clockwise: false
                )
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}

#Preview {
    ExpenseDetailsView(
        selectedMonth: Date(),
        entries: [
            EntryModel(id: "1", date: "2025-04-15T12:00:00+0000", amount: 500, description: "Groceries", imageURLs: [], category: "groceries", tags: []),
            EntryModel(id: "2", date: "2025-04-16T12:00:00+0000", amount: 300, description: "Dinner", imageURLs: [], category: "eating_out", tags: []),
            EntryModel(id: "3", date: "2025-04-17T12:00:00+0000", amount: 200, description: "Gas", imageURLs: [], category: "transport", tags: [])
        ],
        categories: [],
        totalAmount: 1000
    )
}
