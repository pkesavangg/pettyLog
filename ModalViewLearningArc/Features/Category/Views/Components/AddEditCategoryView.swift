//
//  AddEditCategoryView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//

import SwiftUI

struct AddEditCategoryView: View {
    var existingCategory: CategoryModel? = nil
    
    @State var selectedIcon: String = "fork.knife"
    @State var categoryName: String = ""
    @State var showColorSelection: Bool = false
    @State var selectedColor: String = PaletteColor.defaultColor
    @Environment(\.appTheme) private var theme
    @Environment(CategoryAggregateModel.self) var categoryModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var router: Router<SettingsRoute>
    
    var displayColor: Color {
        UIColor(hex: selectedColor).map(Color.init) ?? .clear
    }
    
    var isEditing: Bool {
        existingCategory != nil
    }
    
    var body: some View {
        VStack {
            HStack {
                Button { showColorSelection = true } label: {
                    Circle()
                        .fill(displayColor)
                        .frame(width: 30, height: 30)
                }
                CustomTextField(text: $categoryName, placeholder: "Category Name", inputType: .text)
                    .padding(.horizontal)
                
                if let existingCategory = existingCategory {
                    Button {
                        Task {
                            await categoryModel.deleteCategory(id: existingCategory.id)
                            router.navigateBack()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(theme.error)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            CategoryIconSelectionView(selectedIcon: $selectedIcon)
                .padding(.top)
        }
        .padding(.top)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showColorSelection) {
            ColorSelectionView(selectedColorId: $selectedColor)
        }
        .navigationTitle(isEditing ? "Edit Category" : "Add Category")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Cancel Button on the left
            ToolbarItem(placement: .navigationBarLeading) {
                LinkButton(title: "Cancel".uppercased(), isDisabled: false) {
                    router.navigateBack()
                }
            }
            
            // Delete + Save/Update on the right
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    // Show Delete only in edit mode
                    
                    
                    // Save or Update button
                    LinkButton(
                        title: isEditing ? "Update".uppercased() : "Save".uppercased(),
                        isDisabled: categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    ) {
                        let category = CategoryModel(
                            id: existingCategory?.id ?? UUID().uuidString,
                            name: categoryName,
                            icon: selectedIcon,
                            color: selectedColor,
                            dateCreated: existingCategory?.dateCreated ?? "\(Date().currentTimeMillis())",
                            isDefault: false
                        )
                        Task {
                            await categoryModel.saveCategory(category)
                            router.navigateBack()
                        }
                    }
                }
            }
        }
        
        .onAppear {
            if let category = existingCategory {
                categoryName = category.name
                selectedIcon = category.icon
                selectedColor = category.color
            }
        }
    }
}


extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}


#Preview {
    AddEditCategoryView()
        .environmentObject(ThemeManager.shared)
        .environment(CategoryAggregateModel(authModel: AuthAggregateModel()))
}


import SwiftUI

struct PaletteColor: Codable, Identifiable {
    let id: String
    let name: String
    
    var color: Color {
        return Color(UIColor(hex: id) ?? .clear)
    }
    
    static var defaultColor: String {
        return PaletteColor.all.first?.id ?? "#0B6623"
    }
    
    static let all: [PaletteColor] = [
        PaletteColor(id: "#0B6623", name: "Green"),
        PaletteColor(id: "#B8E0E5", name: "Aqua"),
        PaletteColor(id: "#B2C8E0", name: "Blue Gray"),
        PaletteColor(id: "#F7E7B3", name: "Buttercream"),
        PaletteColor(id: "#FE7968", name: "Coral"),
        PaletteColor(id: "#E2E2E2", name: "Gray"),
        PaletteColor(id: "#E6D9F7", name: "Lavender"),
        PaletteColor(id: "#7EBE5E", name: "Lime"),
        PaletteColor(id: "#FB6EF1", name: "Magenta"),
        PaletteColor(id: "#A8E9D1", name: "Mint"),
        PaletteColor(id: "#FFD1A1", name: "Peach"),
        PaletteColor(id: "#87A8EB", name: "Periwinkle"),
        PaletteColor(id: "#FAD1D1", name: "Pink"),
        PaletteColor(id: "#B991F2", name: "Purple"),
        PaletteColor(id: "#C5E2C4", name: "Sage"),
        PaletteColor(id: "#D6BCAB", name: "Sand"),
        PaletteColor(id: "#94DDFE", name: "Sky Blue"),
        PaletteColor(id: "#FF9549", name: "Tangerine"),
        PaletteColor(id: "#FEE250", name: "Yellow")
    ]
}


struct ColorSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.appTheme) private var theme
    @Binding var selectedColorId: String // Track selected color
    
    var body: some View {
        List {
            ForEach(PaletteColor.all.indices, id: \.self) { index in
                let colorItem = PaletteColor.all[index]
                
                HStack {
                    Circle()
                        .fill(colorItem.color)
                        .frame(width: 30, height: 30)
                    
                    Text(colorItem.name)
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text
                    
                    if selectedColorId == colorItem.id { // Show checkmark if selected
                        Image(systemName: "checkmark")
                            .foregroundStyle(theme.primary)
                    }
                }
                .contentShape(Rectangle()) // Make entire row tappable
                .onTapGesture {
                    selectedColorId = colorItem.id
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("done")
                        .foregroundColor(theme.primary)
                }
            }
        }
    }
}
