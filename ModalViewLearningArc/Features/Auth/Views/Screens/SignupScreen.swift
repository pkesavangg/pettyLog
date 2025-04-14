//
//  SignupScreen.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


import SwiftUI

struct SignupScreen: View {
    @Environment(AuthAggregateModel.self) var authModel
    @EnvironmentObject var router: Router<AuthRoute>
    @State private var viewModel = SignupFlowViewModel()
    @Namespace private var animationNamespace

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if viewModel.step == 0 {
                    NameStepView(viewModel: viewModel)
                        .transition(.move(edge: .leading)
                        .combined(with: .opacity))
                        .zIndex(1)
                }

                if viewModel.step == 1 {
                    EmailStepView(viewModel: viewModel, authModel: authModel)
                        .transition(.move(edge: .trailing)
                        .combined(with: .opacity))
                        .zIndex(0)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.step)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.navigateToRoot()
                } label: {
                    Text("\(Image(systemName: "chevron.left")) Go to login")
                        .foregroundColor(.blue)
                }
            }
        })
        .onDisappear {
            if viewModel.isComplete {
                viewModel.isComplete = false
            }
        }
        .background(
            LinearGradient(colors: [.blue.opacity(0.2), .white], startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview("Not Logged In") {
    SignupScreen()
        .environment(AuthAggregateModel())
        .environmentObject(Router<AuthRoute>())
}

