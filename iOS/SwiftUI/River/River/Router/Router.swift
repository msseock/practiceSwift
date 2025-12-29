//
//  Router.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

final class Router<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []

    func push(_ path: T) {
        paths.append(path)
    }

    func pop() {
        paths.removeLast()
    }

    func goBack(to path: T) {
        guard let found = paths.firstIndex(where: { $0 == path }) else {
            return
        }

        let numToPop = (found..<paths.endIndex).count - 1
        paths.removeLast(numToPop)
    }

    func backToRoot() {
        paths.removeAll()
    }
}
