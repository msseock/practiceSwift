//
//  ContentView.swift
//  PracticeChat
//
//  Created by 석민솔 on 5/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var textInput = ""
    @State private var chatService = ChatService()
    @FocusState private var isFocused: Bool


    var body: some View {
        VStack(alignment: .leading) {
            //MARK: - Chat Message List
            ScrollViewReader(content: { proxy in
                ScrollView {
                    ForEach(chatService.messages) { chatMessage in
                        //MARK: - Chat Message View
                        ChatBox(chatMessage: chatMessage)
                    }
                }
                // 가장 마지막에 생성된 메시지로 스크롤해주기
                .onChange(of: chatService.messages) {
                    guard let recentMessage = chatService.messages.last else { return }
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(recentMessage.id, anchor: .bottom)
                        }
                    }
                }
            })
            .padding(.horizontal)
            
            //MARK: - Input Field
            HStack {
                TextField("메세지를 입력해주세요...", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.black)
                    .focused($isFocused)
                    .disabled(chatService.loadingResponse)
                    
                if chatService.loadingResponse {
                    //MARK: - Loading indicator
                    ProgressView()
                        .tint(.white)
                        .frame(width: 30)
                } else {
                    //MARK: - Send Button
                    Button(action: sendMessage, label: {
                        Image(systemName: "paperplane.fill")
                            .padding(.horizontal)
                            .foregroundStyle(Color.yellow)
                    })
                    .frame(width: 30)
                    .disabled(textInput.isEmpty)
                }
            }
            .padding()
            .background(Color.white)

        }
        .foregroundStyle(.white)
        .background {
            //MARK: - Background
            ZStack {
                Color(red: 247/255, green: 249/255, blue: 250/255)
            }
            .ignoresSafeArea()
            .onTapGesture {
                isFocused = false
            }
            
        }

    }

    //MARK: - Fetch Response
    private func sendMessage() {
        Task {
            await chatService.sendMessage(message: textInput)
            textInput.removeAll()
        }
    }

    
}

#Preview {
    ContentView()
}
