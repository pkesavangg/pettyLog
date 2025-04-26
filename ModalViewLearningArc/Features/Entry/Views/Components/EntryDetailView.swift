//
//  EntryDetailView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 20/04/25.
//

import SwiftUI
import Foundation

struct DataWrapper: Identifiable {
    var id: String { value } // id must be unique
    let value: String
}


struct EntryDetailView: View {
    let entry: EntryModel

    @Environment(\.appTheme) private var theme
    @Environment(\.presentationMode) private var presentationMode
    @Environment(EntryAggregateModel.self) var entryModel
    @EnvironmentObject private var router: Router<EntryRoute>

    @State var selectedImageData: DataWrapper? = nil

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

            // Images section
            VStack(alignment: .leading, spacing: 8) {
                // Image count indicator
                HStack {
                    Image(systemName: AppAssets.photo)
                        .foregroundColor(theme.primary)
                    Text(entry.imageURLs.isEmpty ? lang.bills : "\(entry.imageURLs.count) image(s) attached")
                        .font(.caption)
                        .foregroundColor(theme.onSurface.opacity(0.7))
                }

                if !entry.imageURLs.isEmpty {
                    // Horizontal image scroll view
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(entry.imageURLs, id: \.self) { imageURLString in
                                if let imageURL = URL(string: imageURLString) {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 150, height: 150)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .onTapGesture {
                                                    if imageURL.absoluteString.hasPrefix("http") {
                                                        selectedImageData = DataWrapper(value: imageURL.absoluteString)
                                                    }
                                                }
                                        case .failure:
                                            Image(systemName: AppAssets.photoWithExclamationMark)
                                                .foregroundColor(theme.error)
                                                .frame(width: 150, height: 150)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 150, height: 150)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                } else {

                                    // Display a placeholder for invalid URLs
                                    Image(systemName: AppAssets.photoWithExclamationMark)
                                        .foregroundColor(theme.error)
                                        .frame(width: 150, height: 150)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                } else {
                    // Placeholder when no images are attached
                    BillsPlaceholderView()
                }
            }
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
