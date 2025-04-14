//
//  RoutableObject.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 12/04/25.
//


import SwiftUI
public typealias Routable = View & Hashable

public protocol RoutableObject: AnyObject {

    associatedtype Destination: Routable

    var stack: [Destination] { get set }

    func navigateBack(_ count: Int)

    func navigateBack(to destination: Destination)

    func navigateToRoot()

    func navigate(to destination: Destination)

    func navigate(to destinations: [Destination])

    func replace(with destinations: [Destination])
}

extension RoutableObject {
    public func navigateBack(_ count: Int = 1) {
        guard count > 0 else { return }
        guard count <= stack.count else {
            stack = .init()
            return
        }
        stack.removeLast(count)
    }

    public func navigateBack(to destination: Destination) {
        // Check if the destination exists in the stack
        if let index = stack.lastIndex(where: { $0 == destination }) {
            // Remove destinations above the specified destination
            stack.truncate(to: index)
        }
    }

    public func navigateToRoot() {
        stack = []
    }

    public func navigate(to destination: Destination) {
        stack.append(destination)
    }

    public func navigate(to destinations: [Destination]) {
        stack += destinations
    }

    public func replace(with destinations: [Destination]) {
        stack = destinations
    }
}