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
    private(set) var messages = [ 
        ChatMessage(role: .model, message: "여행 계획이 있으신가요?")
    ]
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
                temperature: 1,
                maxOutputTokens: 100
            )
            
            // For text-only input, use the gemini-pro model
            // Access your API key from your on-demand resource .plist file (see "Set up your API key" above)
            let model = GenerativeModel(
                name: "gemini-1.5-flash-latest",
                apiKey: APIKey.default,
                generationConfig: config,
                safetySettings: [
                    SafetySetting(harmCategory: .harassment, threshold: .blockLowAndAbove),
                    SafetySetting(harmCategory: .hateSpeech, threshold: .blockLowAndAbove),
                    SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockLowAndAbove),
                    SafetySetting(harmCategory: .dangerousContent, threshold: .blockLowAndAbove)

                ],
                systemInstruction: "너는 친절한 한국인 말하기 선생님이야. 한국어를 배우는 외국인 학생이랑 여행에 대한 대화를 나눠보자. 네가 '여행 계획이 있으신가요?'로 질문을 했고, 학생은 그에 이어서 대화를 이어나가는 상황이야. 따라서 User와 대화할 때, 친근한 말투로 쉬운 단어를 사용해서 길지 않게 말해줘. 존댓말을 사용하며, \"-에요.\", \"-하더라고요.\" 말투를 사용해. 여행 장소, 같이 여행가는 사람, 구체적인 여행계획 등에 대한 대화를 하면 돼. 대화가 끊기지 않도록 질문을 계속해줘. 마지막은 '즐거운 여행 되시길 바라요! 😄'로 끝내자"
            )
            
            
            // Initialize the chat
            let chat = model.startChat(history: history)
            
            // 메시지 보내고 응답받기
            let response = try await chat.sendMessage(message)
            if let text = response.text {
//                print("가공 전 text: \(text)")
                
                // 불필요한 \n 제거
                let precessedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                
//                print("가공 후 텍스트:", precessedText)
                
                let lastChatMessageIndex = messages.count - 1
                messages[lastChatMessageIndex].message += precessedText
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
