//
//  EntryFormConfig.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import Foundation
import SwiftUI

struct EntryFormConfig {
    var date: Date = .now
    var amount: String = ""
    var description: String = ""
    var selectedCategoryId: String = ""
    var selectedTagIds: [String] = []
    var isAmountFieldDirty = false
    var isDescFieldDirty = false
    private var errorMessages = ErrorMessages.Validation.self

    var isValid: Bool {
        amountError == nil && descriptionError == nil
    }

    var amountError: String? {
        if amount.trimmingCharacters(in: .whitespaces).isEmpty {
            return errorMessages.emptyField
        }
        if Double(amount) == nil {
            return errorMessages.mustBeNumber
        }
        if let value = Double(amount), value < 0 {
            return errorMessages.mustBePositive
        }
        if let value = Double(amount), value > 30000 {
            return errorMessages.cantExceedMaxValue
        }
        return nil
    }

    var descriptionError: String? {
        let trimmed = description.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return errorMessages.emptyField
        }
        if trimmed.count > 100 {
            return errorMessages.maxLength(100)
        }
        return nil
    }
    
    mutating func reset() {
        date = .now
        amount = ""
        description = ""
        selectedCategoryId = ""
        selectedTagIds = []
        isAmountFieldDirty = false
        isDescFieldDirty = false
    }
}
