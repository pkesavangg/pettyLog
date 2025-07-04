//
//  AddEditTagView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 19/04/25.
//


import SwiftUI

struct AddEditTagView: View {
    var existingTag: TagModel? = nil

    @State private var tagName: String = ""
    @State private var selectedColor: String = PaletteColor.defaultColor
    @State private var showColorSelection: Bool = false
    @State private var isFormDirty: Bool = false

    @Environment(\.appTheme) private var theme
    @Environment(TagAggregateModel.self) private var tagModel
    @Environment(LoaderManager.self) private var loader
    @Environment(ToastManager.self) private var toast
    @EnvironmentObject private var router: Router<SettingsRoute>
    let lang = TagScreenStrings.self
    let loaderLang = LoaderStrings.self

    private var displayColor: Color {
        UIColor(hex: selectedColor).map(Color.init) ?? .clear
    }

    private var isEditing: Bool {
        existingTag != nil
    }

    private var errorMessage: String {
        let trimmed = tagName.trimmingCharacters(in: .whitespacesAndNewlines)
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
            HStack(alignment: .top) {
                Button {
                    showColorSelection = true
                } label: {
                    Circle()
                        .fill(displayColor)
                        .frame(width: 30, height: 30)
                }
                .padding(.top, .p10)

                VStack {
                    CustomTextField(
                        value: $tagName,
                        placeholder: lang.tagFieldPlaceholder,
                        inputType: .text,
                        isDirty: $isFormDirty
                    )

                    ValidationMessageView(message: errorMessage, show: isFormDirty)
                }
                .padding(.horizontal, .p10)

                if let existingTag = existingTag {
                    Button {
                        Task {
                            loader.show(message: loaderLang.deleting)
                            do {
                                try await tagModel.deleteTag(id: existingTag.id)
                                toast.show("✅ Tag deleted successfully", duration: 3.0)
                                router.navigateBack()
                            } catch {
                                toast.show("❌ \(error.localizedDescription)", duration: 3.0)
                            }
                            loader.hide()
                        }
                    } label: {
                        Image(systemName: AppAssets.trash)
                            .foregroundColor(theme.error)
                    }
                    .padding(.top, .p10)
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .padding(.top)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showColorSelection) {
            ColorSelectionView(selectedColorId: $selectedColor)
        }
        .navigationTitle(lang.tagTitle(isEdit: isEditing))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                LinkButton(title: CommonStrings.cancel.uppercased(), isDisabled: false) {
                    router.navigateBack()
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                LinkButton(
                    title: isEditing ? CommonStrings.update.uppercased() : CommonStrings.save.uppercased(),
                    isDisabled: errorMessage != ""
                ) {
                    let tag = TagModel(
                        id: existingTag?.id ?? UUID().uuidString,
                        name: tagName,
                        color: selectedColor,
                        dateCreated: existingTag?.dateCreated ?? "\(Date().currentTimeMillis())",
                        isDefault: false
                    )
                    Task {
                        loader.show(message: isEditing ? loaderLang.updating : loaderLang.saving)
                        do {
                            try await tagModel.saveTag(tag)
                            toast.show("✅ Tag \(isEditing ? "updated" : "saved") successfully", duration: 3.0)
                            router.navigateBack()
                        } catch {
                            toast.show("❌ \(error.localizedDescription)", duration: 3.0)
                        }
                        loader.hide()
                    }
                }
            }
        }
        .onAppear {
            if let tag = existingTag {
                tagName = tag.name
                selectedColor = tag.color
            }
        }
    }
}

#Preview {
    AddEditTagView()
        .environmentObject(ThemeManager.shared)
        .environment(TagAggregateModel(authModel: AuthAggregateModel()))
        .environment(LoaderManager.shared)
        .environment(ToastManager.shared)
}
