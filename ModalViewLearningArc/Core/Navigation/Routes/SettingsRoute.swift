//
//  SettingsRoute.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 14/04/25.
//
import SwiftUI

enum SettingsRoute: Routable {
    case account, categoryList, addEditCategory(CategoryModel?)
    
    var body: some View {
        switch self {
        case .account:
            AccountDetailView()
        case .categoryList:
            CategoryListScreen()
        case .addEditCategory(let category):
            AddEditCategoryView(existingCategory: category)
        }
    }
}


struct AccountDetailView: View {
    var body: some View {
        VStack {
            Text("Account Details")
                .font(.largeTitle)
                .padding()
            // Add more account-related UI elements here
        }
    }
}
