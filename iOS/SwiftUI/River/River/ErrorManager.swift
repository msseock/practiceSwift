//
//  ErrorManager.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/21/25.
//

import Foundation

/// 전역 에러 관리 싱글톤
class ErrorManager: ObservableObject {
    static let shared = ErrorManager()
    
    @Published var hasError: Bool = false
    @Published var currentError: APIResult?
    
    private init() {}
    
    /// 에러 표시
    func showError(_ error: APIResult) {
        DispatchQueue.main.async {
            self.currentError = error
            self.hasError = true
        }
    }
    
    /// 에러 해제
    func clearError() {
        DispatchQueue.main.async {
            self.hasError = false
            self.currentError = nil
        }
    }
    
    /// Error를 APIResult로 변환해서 표시하는 편의 메서드
    func showError(_ error: Error) {
        let apiError: APIResult
        
        if let apiResult = error as? APIResult {
            apiError = apiResult
        } else {
            // 기타 에러는 서버 에러로 처리
            apiError = .serverError
        }
        
        showError(apiError)
    }
}
