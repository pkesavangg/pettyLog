//
//  MonthTotalHeaderView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct MonthTotalHeaderView: View {
    let totalAmount: Double
    let entriesCount: Int
    let onTap: () -> Void

    @Environment(\.appTheme) private var theme
    var lang = EntryScreenStrings.self

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                HStack {
                    Text(lang.totalExpense)
                        .font(.subheadline)
                        .foregroundColor(theme.onSurface.opacity(0.7))

                    Spacer()

                    Text(lang.entriesCount(entriesCount))
                        .font(.caption)
                        .foregroundColor(theme.onSurface.opacity(0.6))
                }

                HStack {
                    Text("₹\(String(format: "%.2f", totalAmount))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(theme.onSurface)

                    Spacer()

                    Image(systemName: "chart.pie.fill")
                        .foregroundColor(theme.primary)
                        .font(.system(size: 18))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(theme.surface)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MonthTotalHeaderView(
        totalAmount: 1234.56,
        entriesCount: 5,
        onTap: {}
    )
    .background(Color.gray.opacity(0.2))
}
