//
//  ErrorView.swift
//  PracticeURLSession
//
//  Created by 석민솔 on 8/20/25.
//

import SwiftUI

struct ErrorView: View {
    let errorType: APIResult
    
    @EnvironmentObject var router: Router<Route>
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.yellow)
                .padding(.bottom)
            
            Text(errorType.errorDescription ?? "알 수 없는 오류")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            Text(errorType.recoverySuggestion ?? "어떻게 해결하지? 껄껄")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            
            // 재시도 버튼
            Button {
                ErrorManager.shared.clearError()
            } label: {
                HStack {
                    Image(systemName: "arrow.trianglehead.clockwise")
                    
                    Text("다시 시도하기")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue.opacity(0.1))
                )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ErrorView(errorType: .invalidAuthKey)
}
