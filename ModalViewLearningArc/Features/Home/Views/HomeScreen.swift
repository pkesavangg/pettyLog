//
//  HomeScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

import SwiftUI

struct HomeScreen: View {
    @Environment(HomeAggregateModel.self) var homeModel

    var body: some View {
        NavigationView {
            Group {
                if homeModel.isLoading {
                    ProgressView()
                } else if let error = homeModel.error {
                    Text(error).foregroundColor(.red)
                } else {
                    List(homeModel.entries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.description)
                            Text("₹\(entry.amount, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
        .task {
            await homeModel.loadEntries()
        }
    }
}
