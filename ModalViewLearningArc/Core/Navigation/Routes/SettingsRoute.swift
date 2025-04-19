//
//  SettingsRoute.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//
import SwiftUI

enum SettingsRoute: Routable {
    case account,
         categories,
         Tags,
         Theme,
         addEditCategory(CategoryModel?),
         addEditTag(TagModel?)
    
    var body: some View {
        switch self {
        case .account:
            AccountDetailView()
        case .categories:
            CategoryScreen()
        case .Tags:
            TagsScreen()
        case .Theme:
            ThemeScreen()
        case .addEditCategory(let category):
            AddEditCategoryView(existingCategory: category)
        case .addEditTag(let tag):
            AddEditTagView(existingTag: tag)
        }
    }
}

struct AccountDetailView: View {
    var body: some View {
        VStack {
            Text("AccountDetailView")
                .font(.largeTitle)
                .padding()
        }
    }
}
