//
//  ToastView.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import SwiftUI

struct ToastView: View {
    @Environment(ToastManager.self) var toastManager
    var body: some View {
        if toastManager.isVisible {
            VStack {
                Text(toastManager.message)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 60)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
    }
}

#Preview {
    let toastManager = ToastManager.shared
    toastManager.show("🔔 This is a toast message!", duration: 5)

    return VStack {
        ToastView()
    }
    .environment(toastManager)
}


