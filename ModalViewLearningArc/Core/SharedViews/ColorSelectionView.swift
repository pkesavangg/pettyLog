//
//  ColorSelectionView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//
import SwiftUI

struct ColorSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.appTheme) private var theme
    @Binding var selectedColorId: String // Track selected color
    let commonLang = CommonStrings.self
    let assets = AppAssets.self
    
    var body: some View {
        VStack {
            List {
                ForEach(PaletteColor.all.indices, id: \.self) { index in
                    let colorItem = PaletteColor.all[index]
                    
                    HStack {
                        Circle()
                            .fill(colorItem.color)
                            .frame(width: 30, height: 30)
                        
                        Text(colorItem.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(theme.onSurface)
                        
                        if selectedColorId == colorItem.id { // Show checkmark if selected
                            Image(systemName: assets.checkmark)
                                .foregroundStyle(theme.primary)
                        }
                    }
                    .contentShape(Rectangle()) // Make entire row tappable
                    .onTapGesture {
                        selectedColorId = colorItem.id
                    }
                }
            }
        }
    }
}


// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var isSheetPresented = false

        var body: some View {
            VStack {
                Button("Select Color") {
                    isSheetPresented = true
                }
                .foregroundColor(.red)
                .padding()
            }
            .sheet(isPresented: $isSheetPresented) {
                ColorSelectionView(selectedColorId: .constant("red"))
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium, .large])
                    .environmentObject(ThemeManager.shared)
                    .environmentObject(Router<SettingsRoute>())
                    
            }
            
        }
    }

    return PreviewWrapper()
}

