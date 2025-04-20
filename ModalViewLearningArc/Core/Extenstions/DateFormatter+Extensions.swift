//
//  DateFormatter+Extensions.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import Foundation

extension DateFormatter {
    static let fullTimestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Example: 2025-04-20T11:58:00+0000
        return formatter
    }()
}
