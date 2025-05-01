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
    
    @Environment(\.appTheme) private var theme
    var lang = EntryScreenStrings.self
    
    var body: some View {
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
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(theme.surface)
    }
}

#Preview {
    MonthTotalHeaderView(totalAmount: 1234.56, entriesCount: 5)
        .background(Color.gray.opacity(0.2))
}
