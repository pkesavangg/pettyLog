//
//  RoutingView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI

public struct RoutingView<Root: View, Routes: Routable>: View {
    @Binding private var routes: [Routes]
    private let root: () -> Root

     public init(
        stack: Binding<[Routes]>,
        @ViewBuilder root: @escaping () -> Root
    ) where Routes: Routable {
        self._routes = stack
        self.root = root
    }
    public var body: some View {
        NavigationStack(path: $routes) {
            root()
                .navigationDestination(for: Routes.self) { view in
                    view
                }
        }
    }
}
