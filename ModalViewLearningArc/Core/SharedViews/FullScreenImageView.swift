//
//  FullScreenImageView.swift
//  ModalViewLearningArc
//
//  Created by Augment Agent on behalf of Kesavan Panchabakesan
//

import SwiftUI

struct FullScreenImageView: View {
    let imageURL: URL?

    @Environment(\.dismiss) private var dismiss
    @Environment(\.appTheme) private var theme

    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)

                    if let imageURL = imageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .tint(.white)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(scale)
                                    .offset(offset)
                                    .gesture(
                                        MagnificationGesture()
                                            .onChanged { value in
                                                let delta = value / lastScale
                                                lastScale = value

                                                // Limit the min and max scale
                                                let newScale = scale * delta
                                                scale = min(max(newScale, 0.5), 4.0)
                                            }
                                            .onEnded { _ in
                                                lastScale = 1.0
                                            }
                                    )
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                let newOffset = CGSize(
                                                    width: lastOffset.width + value.translation.width,
                                                    height: lastOffset.height + value.translation.height
                                                )

                                                // Limit the drag area based on scale
                                                let maxOffsetX = (geometry.size.width * (scale - 1)) / 2
                                                let maxOffsetY = (geometry.size.height * (scale - 1)) / 2

                                                offset = CGSize(
                                                    width: min(max(newOffset.width, -maxOffsetX), maxOffsetX),
                                                    height: min(max(newOffset.height, -maxOffsetY), maxOffsetY)
                                                )
                                            }
                                            .onEnded { _ in
                                                lastOffset = offset
                                            }
                                    )
                                    .onTapGesture(count: 2) {
                                        withAnimation {
                                            if scale > 1.0 {
                                                // Reset to normal
                                                scale = 1.0
                                                offset = .zero
                                                lastOffset = .zero
                                            } else {
                                                // Zoom in
                                                scale = 2.0
                                            }
                                        }
                                    }
                            case .failure:
                                VStack {
                                    Image(systemName: AppAssets.photoWithExclamationMark)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)

                                    Text("Failed to load image")
                                }
                                .foregroundColor(.white)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Text("No image availables")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: AppAssets.xmarkCircle)
                            .foregroundColor(theme.primary)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let imageURL = imageURL {
                            shareImage(imageURL: imageURL)
                        } else {
                            showErrorAlert(message: "No image available to share")
                        }
                    } label: {
                        Image(systemName: AppAssets.squareAndArrow)
                            .foregroundColor(theme.primary)
                    }
                }
            }
        }
    }

    private func shareImage(imageURL: URL) {

        // Download the image data
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.showShareError(message: "Failed to download image")
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    self.showShareError(message: "Failed to process image")
                    return
                }

                // Share the image using UIActivityViewController
                self.presentShareSheet(with: image)
            }
        }.resume()
    }

    private func presentShareSheet(with image: UIImage) {
        // Get the root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        // Find the currently presented view controller
        var currentController = rootViewController
        while let presented = currentController.presentedViewController {
            currentController = presented
        }

        // Create activity view controller with the actual image
        let activityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )

        // For iPad, set the popover presentation controller
        if let popover = activityViewController.popoverPresentationController {
            popover.sourceView = currentController.view
            popover.sourceRect = CGRect(x: currentController.view.bounds.midX,
                                       y: currentController.view.bounds.midY,
                                       width: 0, height: 0)
            popover.permittedArrowDirections = []
        }

        // Present the activity view controller
        currentController.present(activityViewController, animated: true)
    }

    private func showShareError(message: String) {

        // Get the root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        // Find the currently presented view controller
        var currentController = rootViewController
        while let presented = currentController.presentedViewController {
            currentController = presented
        }

        // Create and present the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        currentController.present(alert, animated: true)
    }

    private func showErrorAlert(message: String) {

        // Get the root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        // Find the currently presented view controller
        var currentController = rootViewController
        while let presented = currentController.presentedViewController {
            currentController = presented
        }

        // Create and present the alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        currentController.present(alert, animated: true)
    }
}

#Preview {
    FullScreenImageView(imageURL: URL(string: "https://example.com/image.jpg"))
}
