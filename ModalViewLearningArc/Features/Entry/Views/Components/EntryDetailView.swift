//
//  EntryDetailView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import SwiftUI

struct EntryDetailView: View {
    let entry: EntryModel

    @Environment(\.appTheme) private var theme
    @Environment(\.presentationMode) private var presentationMode
    @Environment(EntryAggregateModel.self) var entryModel
    @EnvironmentObject private var router: Router<EntryRoute>
    var lang = EntryScreenStrings.self
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Amount
            Text("₹\(String(format: "%.2f", entry.amount))")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(theme.onSurface)

            // Description
            Text(entry.description)
                .font(.body)
                .foregroundColor(theme.onSurface.opacity(0.8))

            // Category
            if let category = category {
                HStack(spacing: 8) {
                    CategoryIconView(iconName: category.icon)
                    Text(category.name)
                        .font(.subheadline)
                        .foregroundColor(theme.onSurface)
                }
            }

            // Tags
            if !tags.isEmpty {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.id) { tag in
                        TagChipView(tag: tag)
                    }
                }
            }

            // Image indicator
            if !entry.imageURLs.isEmpty {
                HStack {
                    Image(systemName: AppAssets.photo)
                        .foregroundColor(theme.primary)
                    Text("\(entry.imageURLs.count) image(s) attached")
                        .font(.caption)
                        .foregroundColor(theme.onSurface.opacity(0.7))
                }
            }
        }
        .padding()
        .navigationTitle(lang.entryDetails)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        router.navigate(to: .addEditEntry(entry))
                    } label: {
                        Image(systemName: AppAssets.pencil)
                            .foregroundColor(theme.primary)
                    }
                    Button {
                        Task {
                           await entryModel.deleteEntry(id: entry.id)
                            router.navigateToRoot()
                        }
                    } label: {
                        Image(systemName: AppAssets.trash)
                            .foregroundColor(theme.primary)
                    }
                }

            }
        }
            
    }
    
    private var category: CategoryModel? {
        entryModel.getCategories().first { $0.id == entry.category }
    }

    private var tags: [TagModel] {
        entryModel.getTags()
            .filter { (entry.tags ?? []).contains($0.id) }
    }
}


#Preview {
    EntryDetailView(
        entry: EntryModel(id: "",
                                      date: "",
                                      amount: 22,
                                      description: "dds",
                                      imageURLs: ["String"], category: ""))
}
