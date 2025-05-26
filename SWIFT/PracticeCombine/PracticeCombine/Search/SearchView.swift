//
//  SearchView.swift
//  PracticeCombine
//
//  Created by 석민솔 on 5/26/25.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // 검색 입력 필드
                TextField("검색어를 입력하세요", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // 로딩 인디케이터
                if viewModel.isLoading {
                    ProgressView("검색 중...")
                        .padding()
                }
                
                // 검색 결과
                List(viewModel.searchResults, id: \.self) { result in
                    Text(result)
                        .padding(.vertical, 4)
                }
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .navigationTitle("Combine 검색")
        }
    }
}
