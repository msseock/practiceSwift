//
//  SearchService.swift
//  PracticeCombine
//
//  Created by 석민솔 on 5/26/25.
//

import Foundation
import Combine

// Search Service with Combine
class SearchService {
    private let mockData = [
        "Apple", "Application", "Approach", "Append",
        "Swift", "SwiftUI", "Swimming", "Switch",
        "Combine", "Computer", "Coffee", "Code"
    ]
    
    func search(_ query: String) -> AnyPublisher<[String], Never> {
        // 네트워크 지연 시뮬레이션
        Just(mockData)
            .delay(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { data in
                data.filter { $0.lowercased().contains(query.lowercased()) }
            }
            .eraseToAnyPublisher()
    }
}
