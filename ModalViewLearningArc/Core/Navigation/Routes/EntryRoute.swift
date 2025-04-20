//
//  EntryRoute.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import SwiftUI

enum EntryRoute: Routable {
   case addEditEntry(EntryModel?)
    var body: some View {
        switch self {
        case .addEditEntry(let entry):
            EntryAddEditView(existingEntry: entry)
        }
    }
}