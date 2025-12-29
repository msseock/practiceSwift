//
//  RiverStageListViewModel.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

class RiverStageListViewModel: ObservableObject {
    @Published var riversList: [String] = []
    @Published var isLoading: Bool = false
    
    let riverRepository = RiverRepository()
    
    func fetchRiverListInfo() async {
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            let response = try await riverRepository.fetchRiversList()
            
            guard !response.isEmpty else {
                await MainActor.run {
                    self.isLoading = false
                }
                return 
            }
            
            await MainActor.run {
                self.riversList = response.map {
                    $0.riverName
                }
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
            }
            // 에러 처리도 MainActor에서 실행
            handleError(error)
        }
    }
    
    func fetchError() async {
        do {
            let _ = try await riverRepository.fetchErrorData()
            
        } catch {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error) {
        // APIResult가 throw된 경우와 다른 에러를 구분하여 처리
        if let apiError = error as? APIResult {
            ErrorManager.shared.showError(apiError)
        } else {
            // 기타 에러는 서버 에러로 처리
            ErrorManager.shared.showError(.serverError)
        }
    }
}
