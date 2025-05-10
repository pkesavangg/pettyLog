//
//  NetworkMonitor.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import Network
import Foundation
import Combine
import SwiftUI

@Observable
@MainActor
final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var networkState: NetworkState = .connected

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let connected = path.status == .satisfied
                self?.networkState = connected ? .connected : .disconnected

                if !connected {
                    ToastManager.shared.show("No Internet Connection 😢", duration: 99999)
                } else {
                    ToastManager.shared.isVisible = false // hide toast on reconnect
                }
            }
        }
        monitor.start(queue: queue)
    }
}
