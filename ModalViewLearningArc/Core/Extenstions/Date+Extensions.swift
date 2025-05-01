//
//  Date+Extensions.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }

    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }

    func endOfMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return calendar.date(byAdding: components, to: self.startOfMonth()) ?? self
    }

    func isSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        let selfComponents = calendar.dateComponents([.year, .month], from: self)
        let otherComponents = calendar.dateComponents([.year, .month], from: date)
        return selfComponents.year == otherComponents.year && selfComponents.month == otherComponents.month
    }

    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }

    static func monthsBetween(start: Date, end: Date) -> [Date] {
        let calendar = Calendar.current
        var months: [Date] = []
        var currentDate = start.startOfMonth()

        while currentDate <= end {
            months.append(currentDate)
            guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) else { break }
            currentDate = nextMonth
        }

        return months
    }

    func formattedMonthYear() -> String {
        return DateFormatter.monthYearFormatter.string(from: self)
    }

    func formattedDayMonth() -> String {
        return DateFormatter.dayMonthFormatter.string(from: self)
    }

    func formattedDayOfWeek() -> String {
        return DateFormatter.dayOfWeekFormatter.string(from: self)
    }
}
