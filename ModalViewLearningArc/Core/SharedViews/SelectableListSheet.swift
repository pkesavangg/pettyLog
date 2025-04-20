//
//  SelectableListSheet.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import SwiftUI

struct SelectableListSheet<T: Identifiable & Hashable>: View {
    var title: String
    var items: [T]
    var selectionMode: SelectionMode
    var displayName: (T) -> String
    
    @Binding var selectedSingleId: String
    @Binding var selectedMultipleIds: [String]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        NavigationStack {
            List(items, id: \.id) { item in
                Button {
                    switch selectionMode {
                    case .single:
                        selectedSingleId = item.id as! String
                        dismiss()
                    case .multiple:
                        let id = item.id as! String
                        if selectedMultipleIds.contains(id) {
                            selectedMultipleIds.removeAll { $0 == id }
                        } else {
                            selectedMultipleIds.append(id)
                        }
                    }
                } label: {
                    HStack {
                        Text(displayName(item))
                            .foregroundColor(theme.onSurface)
                        Spacer()
                        switch selectionMode {
                        case .single where selectedSingleId == (item.id as! String),
                             .multiple where selectedMultipleIds.contains(item.id as! String):
                            Image(systemName: AppAssets.checkmark)
                                .foregroundStyle(theme.primary)
                            
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(CommonStrings.done)
                            .foregroundColor(theme.primary)
                    }

                }
            }
            .accentColor(theme.primary)
        }
    }
}
