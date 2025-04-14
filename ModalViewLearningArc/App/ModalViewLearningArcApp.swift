//
//  ModalViewLearningArcApp.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//

import SwiftUI
import Firebase

@main
struct MyApp: App {
    let authModel = AuthAggregateModel()
    let themeManager = ThemeManager.shared

    init() {
        _ = NetworkMonitor.shared
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                ToastView()
            }            
            .environmentObject(themeManager) // ✅ Fixes the crash
            .environment(authModel)
            .environment(ToastManager.shared)
        }
    }
}








// MARK: - TestViewModel For @Observable macro understanding purpose.

import SwiftUI

@Observable
class TestViewModel {
    var name = "Test"
}

struct MainView: View {
    let viewModel = TestViewModel()

    var body: some View {
        @Bindable var bindableTestViewModel = viewModel
        return VStack {
            Text("Main View: \(viewModel.name)")
            TextField("Enter name", text: $bindableTestViewModel.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            InputView()
            AnotherInputView(testViewModel: viewModel)
        }
        .environment(viewModel)
    }
}

struct InputView: View {
    @Environment(TestViewModel.self) private var testViewModel

    var body: some View {
        @Bindable var bindableTestViewModel = testViewModel

        return TextField("Enter name", text: $bindableTestViewModel.name)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct AnotherInputView: View {
    @Bindable var testViewModel: TestViewModel
    var body: some View {
        TextField("Enter name", text: $testViewModel.name)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}


#Preview {
    MainView()
}
        


