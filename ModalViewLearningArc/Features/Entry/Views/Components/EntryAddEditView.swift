//
//  EntryAddEditView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//


import SwiftUI

struct EntryAddEditView: View {
    var existingEntry: EntryModel? = nil
    @State private var form = EntryFormConfig()
    @State private var showCategorySheet = false
    @State private var showTagsSheet = false
    @Environment(EntryAggregateModel.self) private var entryModel
    @Environment(\.appTheme) private var theme
    @EnvironmentObject private var router: Router<EntryRoute>
    
    let lang = EntryScreenStrings.self
    let commonLang = CommonStrings.self

    var isEditing: Bool {
        existingEntry != nil
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(lang.dateFieldLabel)
                    .formLabelStyle()
                DatePicker(
                    "",
                    selection: $form.date,
                    in: ...Date.now,
                    displayedComponents: .date
                )
            }


            VStack {
                CustomTextField(value: $form.amount,
                                placeholder: lang.amountFieldPlaceholder,
                                inputType: .number,
                                label: lang.amountFieldLabel,
                                isDirty: $form.isAmountFieldDirty)
                ValidationMessageView(message: form.amountError ?? "", show: form.isAmountFieldDirty)
            }

            VStack {
                CustomTextField(value: $form.description,
                                placeholder: lang.descriptionFieldPlaceholder,
                                inputType: .text,
                                label: lang.descriptionFieldLabel,
                                isDirty: $form.isDescFieldDirty)
                ValidationMessageView(message: form.descriptionError ?? "", show: form.isDescFieldDirty)
            }

            Button {
                showCategorySheet = true
            } label: {
                HStack {
                    Text(lang.categoryFieldLabel)
                        .formLabelStyle()
                    Spacer()
                    if let category = selectedCategory {
                        Text(category.name)
                            .font(.caption)
                            .padding(.horizontal, .p12)
                            .padding(.vertical, .p6)
                            .background(category.displayColor)
                            .foregroundColor(theme.onPrimary)
                            .clipShape(Capsule())
                    }
                }
            }

            Button {
                showTagsSheet = true
            } label: {
                HStack {
                    Text(lang.tagFieldLabel)
                        .formLabelStyle()
                    Spacer()
                    Group {
                        if selectedTagNames.count == 0 {
                            Text("Add Tags +")
                        } else {
                            Text(selectedTagNames.joined(separator: ", "))
                        }
                    }
                    .foregroundColor(theme.onSurface)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(lang.entryTitle(isEditing))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? commonLang.update : commonLang.save) {
                    let entry = EntryModel(
                        id: existingEntry?.id ?? UUID().uuidString,
                        date:  DateFormatter.fullTimestampFormatter.string(from: form.date)
,
                        amount: Double(form.amount) ?? 0,
                        description: form.description,
                        imageURLs: existingEntry?.imageURLs ?? [],
                        category: form.selectedCategoryId,
                        tags: form.selectedTagIds
                    )
                    form.reset()
                    Task {
                        await entryModel.saveEntry(entry)
                        router.navigateBack()
                    }
                }
                .disabled(!form.isValid)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showCategorySheet) {
            SelectableListSheet(
                title: lang.sheetTitle(true),
                items: entryModel.getCategories(),
                selectionMode: .single,
                displayName: { $0.name },
                selectedSingleId: $form.selectedCategoryId,
                selectedMultipleIds: .constant([]) // Not used in single mode
            )
        }

        .sheet(isPresented: $showTagsSheet) {
            SelectableListSheet(
                title: lang.sheetTitle(false),
                items: entryModel.getTags(),
                selectionMode: .multiple,
                displayName: { $0.name },
                selectedSingleId: .constant(""), // Not used in multiple mode
                selectedMultipleIds: $form.selectedTagIds
            )
        }
        .onAppear {
            if let entry = existingEntry {
                form.date = DateFormatter.fullTimestampFormatter.date(from: entry.date) ?? .now
                form.amount = String(entry.amount)
                form.description = entry.description
                form.selectedCategoryId = entry.category
                form.selectedTagIds = entry.tags ?? []
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let categories = entryModel.getCategories()
                if form.selectedCategoryId.isEmpty, let first = categories.first {
                    form.selectedCategoryId = first.id
                }
            }
        }
    }

    private var selectedCategory: CategoryModel? {
        entryModel.getCategories().first { $0.id == form.selectedCategoryId }
    }

    private var selectedTagNames: [String] {
        entryModel.getTags()
            .filter { form.selectedTagIds.contains($0.id) }
            .map(\.name)
    }
}