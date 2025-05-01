//
//  MonthSelectorView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct MonthSelectorView: View {
    @Binding var selectedMonth: Date
    let availableMonths: [Date]

    @Environment(\.appTheme) private var theme
    @State private var scrollToSelected: Bool = false

    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(availableMonths, id: \.self) { month in
                        Button {
                            withAnimation {
                                selectedMonth = month
                                scrollToSelected = true
                            }
                        } label: {
                            Text(month.formattedMonthYear())
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(
                                    Capsule()
                                        .fill(month.isSameMonth(as: selectedMonth) ? theme.primary : .clear)
                                )
                                .foregroundColor(month.isSameMonth(as: selectedMonth) ? .white : theme.onSurface)
                                .fontWeight(month.isSameMonth(as: selectedMonth) ? .bold : .regular)
                        }
                        .id(month) // Use the month as the ID for scrolling
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .onChange(of: scrollToSelected) {
                    if scrollToSelected {
                        withAnimation {
                            scrollView.scrollTo(selectedMonth, anchor: .center)
                        }
                        scrollToSelected = false
                    }
                }

            }
            .onAppear {
                // Scroll to the selected month when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        scrollView.scrollTo(selectedMonth, anchor: .center)
                    }
                }
            }
            .onChange(of: selectedMonth) { _, newMonth in
                // Scroll to the selected month when it changes externally
                withAnimation {
                    scrollView.scrollTo(newMonth, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    let months = [
        Date().startOfMonth(),
        Calendar.current.date(byAdding: .month, value: -1, to: Date())!.startOfMonth(),
        Calendar.current.date(byAdding: .month, value: -2, to: Date())!.startOfMonth()
    ]

    return MonthSelectorView(
        selectedMonth: .constant(Date().startOfMonth()),
        availableMonths: months
    )
    .background(Color.red)
}
