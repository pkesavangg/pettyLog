//
//  EntryDetailView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import SwiftUI
import Foundation

struct EntryDetailView: View {
    let entry: EntryModel

    @Environment(\.appTheme) private var theme
    @Environment(\.presentationMode) private var presentationMode
    @Environment(EntryAggregateModel.self) var entryModel
    @EnvironmentObject private var router: Router<EntryRoute>

    @Environment(LoaderManager.self) var loader
    @Environment(ToastManager.self) var toast
    @State var selectedImageData: DataWrapper? = nil

    var lang = EntryScreenStrings.self
    var loaderLang = LoaderStrings.self

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
                    CategoryIconView(iconName: category.icon, displayColor: category.displayColor)                        
                    Text(category.name)
                        .font(.subheadline)
                        .foregroundColor(theme.onSurface)
                }
            }

            // Tags
            if !tags.isEmpty {
                WrappingChipsView(
                    tags: tags,
                    showAddButton: false
                ) { tag in
                    Text(tag.name)
                        .pillStyle(backgroundColor: tag.displayColor)
                } onAddTapped: {}
            }

            // Images section
            EntryImageSectionView(
                imageURLs: entry.imageURLs,
                onImageTap: { imageURLString in
                    if let url = URL(string: imageURLString), url.absoluteString.hasPrefix("http") {
                        selectedImageData = DataWrapper(value: url.absoluteString)
                    }
                }
            )
            Spacer()
        }
        .padding()
        .navigationTitle(lang.entryDetails)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
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
                        Task{
                            loader.show(message: loaderLang.deleting)
                            do {
                                try await entryModel.deleteEntry(id: entry.id)
                                router.navigateToRoot()
                            } catch {
                                toast.show("❌ \(error.localizedDescription)", duration: 3.0)
                            }
                            loader.hide()
                        }

                    } label: {
                        Image(systemName: AppAssets.trash)
                            .foregroundColor(theme.primary)
                    }
                }
            }
        }
        .sheet(item: $selectedImageData) { category in
            FullScreenImageView(imageURL: URL(string: category.value))
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
    Group {
        // Preview with images
        EntryDetailView(
            entry: EntryModel(
                id: "preview-id-1",
                date: DateFormatter.fullTimestampFormatter.string(from: Date()),
                amount: 1299.99,
                description: "New laptop purchase for work",
                imageURLs: [
                    "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg",
                    "https://res.cloudinary.com/drvtbf98f/image/upload/v1745658534/ijyqwt4r0w6kurwef5bi.jpg"
                ],
                category: "electronics",
                tags: ["work", "tech"]
            )
        )
        .environmentObject(Router<EntryRoute>())
        .environment(EntryAggregateModel(
            authModel: AuthAggregateModel(),
            categoryModel: CategoryAggregateModel(authModel: AuthAggregateModel()),
            tagModel: TagAggregateModel(authModel: AuthAggregateModel())
        ))

        // Preview without images
        EntryDetailView(
            entry: EntryModel(
                id: "preview-id-2",
                date: DateFormatter.fullTimestampFormatter.string(from: Date()),
                amount: 499.50,
                description: "Office supplies",
                imageURLs: [],
                category: "office",
                tags: ["work", "supplies"]
            )
        )
        .environmentObject(Router<EntryRoute>())
        .environment(EntryAggregateModel(
            authModel: AuthAggregateModel(),
            categoryModel: CategoryAggregateModel(authModel: AuthAggregateModel()),
            tagModel: TagAggregateModel(authModel: AuthAggregateModel())
        ))
    }
}
