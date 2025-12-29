//
//  RiverInfoViewModel.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

class RiverInfoViewModel: ObservableObject {
    @Published var riverName: String?
    @Published var waterHeight: CGFloat?
    
    let riverRepository = RiverRepository()

    func fetchRiverInfo(name: String) async {
        do {
            let response = try await riverRepository.fetchSingleRiver(name: name)
            
            await MainActor.run {
                self.riverName = response.riverName
                self.waterHeight = CGFloat(response.realTimeWaterLevel)
            }
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
