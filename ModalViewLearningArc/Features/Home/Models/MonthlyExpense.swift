//
//  MonthlyExpense.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import Foundation
import SwiftUI

struct MonthlyExpense: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
    let entriesCount: Int
    
    // Computed properties for display
    var monthYear: String {
        return date.formattedMonthYear()
    }
    
    var shortMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yy"
        return formatter.string(from: date)
    }
    
    // For percentage change calculation
    func percentageChange(from previousMonth: MonthlyExpense?) -> Double? {
        guard let previousMonth = previousMonth, previousMonth.amount > 0 else {
            return nil
        }
        
        return ((amount - previousMonth.amount) / previousMonth.amount) * 100
    }
}
