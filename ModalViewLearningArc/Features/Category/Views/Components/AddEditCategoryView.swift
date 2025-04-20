//
//  AddEditCategoryView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 15/04/25.
//

import SwiftUI

struct AddEditCategoryView: View {
    var existingCategory: CategoryModel? = nil
    
    @State var selectedIcon: String = ""
    @State var categoryName: String = ""
    @State var showColorSelection: Bool = false
    @State var selectedColor: String = PaletteColor.defaultColor
    @Environment(\.appTheme) private var theme
    @Environment(CategoryAggregateModel.self) var categoryModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var router: Router<SettingsRoute>
    @State var isFormDirty: Bool = false
    let lang = CategoryScreenStrings.self
    
    var displayColor: Color {
        UIColor(hex: selectedColor).map(Color.init) ?? .clear
    }
    
    var isEditing: Bool {
        existingCategory != nil
    }
    
    var errorMessage: String {
        let trimmed = categoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return ErrorMessages.Validation.emptyField
        }
        if trimmed.count > 15 {
            return ErrorMessages.Validation.minLength(15)
        }
        return ""
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
//                    Button {
//                        showColorSelection = true
//                    } label: {
//                        Circle()
//                            .fill(displayColor)
//                            .frame(width: 30, height: 30)
//                    }
//                    .padding(.top, .p10)
                    VStack {
                        CustomTextField(value: $categoryName, placeholder: lang.categoryFieldPlaceholder, inputType: .text,
                                        isDirty: $isFormDirty)
                        ValidationMessageView(message: errorMessage, show: isFormDirty)
                        
                    }
                    .padding(.horizontal, .p10)

                    
                    if let existingCategory = existingCategory {
                        Button {
                            Task {
                                await categoryModel.deleteCategory(id: existingCategory.id)
                                router.navigateBack()
                            }
                        } label: {
                            Image(systemName: AppAssets.trash)
                                .foregroundColor(theme.error)
                        }
                        .padding(.top, .p10)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            
            
            IconSelectionView(selectedIcon: $selectedIcon)
                .padding(.top)
        }
        .padding(.top)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showColorSelection) {
            ColorSelectionView(selectedColorId: $selectedColor)
        }
        .navigationTitle(lang.categoryTitle(isEdit: isEditing))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Cancel Button on the left
            ToolbarItem(placement: .navigationBarLeading) {
                LinkButton(title: CommonStrings.cancel.uppercased(), isDisabled: false) {
                    router.navigateBack()
                }
            }
            
            // Delete + Save/Update on the right
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    // Show Delete only in edit mode
                    
                    
                    // Save or Update button
                    LinkButton(
                        title: isEditing ? CommonStrings.update.uppercased() : CommonStrings.save.uppercased(),
                        isDisabled: errorMessage != "",
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

#Preview {
    AddEditCategoryView()
        .environmentObject(ThemeManager.shared)
        .environment(CategoryAggregateModel(authModel: AuthAggregateModel()))
}
