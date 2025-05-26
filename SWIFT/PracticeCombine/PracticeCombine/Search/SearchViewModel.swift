//
//  SearchViewModel.swift
//  PracticeCombine
//
//  Created by 석민솔 on 5/26/25.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [String] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let searchService = SearchService()
    
    init() {
        // Combine 파이프라인 설정
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.performSearch(searchText)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(_ text: String) {
        guard !text.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        
        searchService.search(text)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        print("Search error: \(error)")
                        self?.searchResults = []
                    }
                },
                receiveValue: { [weak self] results in
                    self?.searchResults = results
                }
            )
            .store(in: &cancellables)
    }
}

