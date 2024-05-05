//
//  ChatService.swift
//  PracticeChat
//
//  Created by 석민솔 on 5/5/24.
//

import SwiftUI
import GoogleGenerativeAI

@Observable
class ChatService {
    private(set) var messages = [ChatMessage]()
    private(set) var history = [ModelContent]()
    private(set) var loadingResponse = false
    
    func sendMessage(message: String) async {
        
        loadingResponse = true  // 로딩 시작
        
        // MARK: - 유저 메시지, AI 메시지를 리스트에 추가
        messages.append(.init(role: .user, message: message))
        messages.append(.init(role: .model, message: ""))
        
        do {
            // MARK: - 멀티턴 대화
            let config = GenerationConfig(
                maxOutputTokens: 100
            )
            
            // For text-only input, use the gemini-pro model
            // Access your API key from your on-demand resource .plist file (see "Set up your API key" above)
            let model = GenerativeModel(
                name: "gemini-pro",
                apiKey: APIKey.default,
                generationConfig: config
            )
            
            
            // Initialize the chat
            let chat = model.startChat(history: history)
            
            // 메시지 보내고 응답받기
            let response = try await chat.sendMessage(message)
            if let text = response.text {
                print(text)
            }
            
            history.append(.init(role: "user", parts: message))
            history.append(.init(role: "model", parts: messages.last?.message ?? ""))
            
            loadingResponse = false // 로딩 끝내기

        }
        catch {
            loadingResponse = false
            messages.removeLast()
            messages.append(.init(role: .model, message: "다시 시도해주세요."))
            print(error.localizedDescription)
        }
    }
    
    
}
