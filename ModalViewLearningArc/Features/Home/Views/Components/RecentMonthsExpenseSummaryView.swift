//
//  RecentMonthsExpenseSummaryView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct RecentMonthsExpenseSummaryView: View {
    let recentMonths: [MonthlyExpense]
    
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Months")
                .font(.headline)
                .foregroundColor(theme.onSurface)
            
            if recentMonths.isEmpty {
                Text("No recent expense data available")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(theme.onSurface.opacity(0.7))
            } else {
                VStack(spacing: 12) {
                    ForEach(recentMonths) { expense in
                        monthRow(expense)
                    }
                }
            }
        }
        .padding()
        .background(theme.surface)
        .cornerRadius(12)
        .shadow(color: theme.onSurface.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func monthRow(_ expense: MonthlyExpense) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.monthYear)
                    .font(.subheadline)
                    .foregroundColor(theme.onSurface)
                
                Text("\(expense.entriesCount) entries")
                    .font(.caption)
                    .foregroundColor(theme.onSurface.opacity(0.7))
            }
            
            Spacer()
            
            Text("₹\(String(format: "%.2f", expense.amount))")
                .font(.headline)
                .foregroundColor(theme.primary)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(theme.surface.opacity(0.5))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(theme.onSurface.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    RecentMonthsExpenseSummaryView(
        recentMonths: HomeAggregateModel.withSampleData().getRecentMonths()
    )
    .padding()
    .background(Color(.systemBackground))
}
