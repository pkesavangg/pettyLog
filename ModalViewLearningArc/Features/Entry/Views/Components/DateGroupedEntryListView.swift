//
//  DateGroupedEntryListView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct DateGroupedEntryListView: View {
    let entries: [EntryModel]
    let categories: [CategoryModel]
    let tags: [TagModel]
    let onEntryTap: (EntryModel) -> Void
    
    @Environment(\.appTheme) private var theme
    
    private var groupedEntries: [String: [EntryModel]] {
        Dictionary(grouping: entries) { entry in
            // Extract date part only (without time) for grouping
            if let date = DateFormatter.fullTimestampFormatter.date(from: entry.date) {
                return DateFormatter.dayMonthFormatter.string(from: date)
            }
            return "Unknown Date"
        }
    }
    
    private var sortedDates: [String] {
        groupedEntries.keys.sorted { date1, date2 in
            // Convert back to Date for proper sorting
            guard let date1Obj = parseGroupDate(date1),
                  let date2Obj = parseGroupDate(date2) else {
                return date1 > date2 // Fallback to string comparison
            }
            return date1Obj > date2Obj // Sort newest first
        }
    }
    
    private func parseGroupDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        return formatter.date(from: dateString)
    }
    
    private func dayOfWeek(for dateString: String) -> String {
        if let date = parseGroupDate(dateString) {
            return date.formattedDayOfWeek().uppercased()
        }
        return ""
    }
    
    var body: some View {
        List {
            ForEach(sortedDates, id: \.self) { dateString in
                Section(header: 
                    HStack {
                        Text(dateString.uppercased())
                            .font(.subheadline)
                            .foregroundColor(theme.onSurface)
                        Spacer()
                        Text(dayOfWeek(for: dateString))
                            .font(.caption)
                            .foregroundColor(theme.onSurface.opacity(0.7))
                    }
                    .padding(.vertical, 4)
                ) {
                    ForEach(groupedEntries[dateString] ?? [], id: \.id) { entry in
                        Button {
                            onEntryTap(entry)
                        } label: {
                            EntryListRowView(
                                entry: entry,
                                categories: categories,
                                tags: tags
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let dummyEntries = [
        EntryModel(
            id: "1",
            date: "2025-04-20T12:00:00+0000",
            amount: 199.99,
            description: "Grocery shopping",
            imageURLs: [],
            category: "groceries",
            tags: ["food"]
        ),
        EntryModel(
            id: "2",
            date: "2025-04-20T15:00:00+0000",
            amount: 49.99,
            description: "Dinner",
            imageURLs: [],
            category: "food",
            tags: ["dinner"]
        ),
        EntryModel(
            id: "3",
            date: "2025-04-19T10:00:00+0000",
            amount: 29.99,
            description: "Books",
            imageURLs: [],
            category: "education",
            tags: ["learning"]
        )
    ]
    
    return DateGroupedEntryListView(
        entries: dummyEntries,
        categories: [],
        tags: [],
        onEntryTap: { _ in }
    )
}
