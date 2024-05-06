//
//  ChatBox.swift
//  PracticeChat
//
//  Created by 석민솔 on 5/6/24.
//

import SwiftUI

struct ChatBox: View {
    let chatMessage: ChatMessage
    var message: String {
        chatMessage.message
    }
    var role: ChatRole {
        chatMessage.role
    }
    var boxColor: Color {
        return role == .model ? .white : Color(red: 253/255, green: 224/255, blue: 139/255)
    }
    
    var body: some View {
        HStack {
            // 로딩중인 경우(모델 답변 기다리는중일 때)
            if message.isEmpty {
                ProgressView()
                    .padding()
                    .background(boxColor)
                    .tint(.black)
                    .clipShape(ChatBubbleShape(role: role))
                Spacer()
            }
            // 로딩 끝
            else {
                // 유저일 경우에 오른쪽부터 말풍선 띄워주기
                if role == .user {
                    Spacer()
                    
                    Text(message)
                        .padding(16)
                        .background(boxColor)
                        .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))

                // 모델일 경우 왼쪽부터 말풍선 띄워주기
                } else {
                    Text(message)
                        .padding(16)
                        .background(boxColor)
                        .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))
                    
                    Spacer()
                }
            }
        }
    }
}

struct ChatBubbleShape: Shape {
    /// 채팅 역할에 따라 모양 달라져야하기 때문에 채팅 역할이 모델인지, 유저인지 입력받음
    let role: ChatRole
    
    /// 모델이면 왼쪽 끝 뾰족하게 계산
    var topLeftRadius: CGFloat {
        return role == .model ? 4 : 16
    }
    /// 유저면 오른쪽 끝 뾰족하게 계산
    var topRightRadius: CGFloat {
        return role == .user ? 4 : 16
    }
    // 나머지는 16으로 고정
    let bottomLeftRadius: CGFloat = 16
    let bottomRightRadius: CGFloat = 16

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // 시작점 설정
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        
        // 오른쪽 상단 모서리
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                    radius: topRightRadius,
                    startAngle: .pi * 1.5,
                    endAngle: 0,
                    clockwise: true)
        
        // 오른쪽 하단 모서리
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                    radius: bottomRightRadius,
                    startAngle: 0,
                    endAngle: .pi * 0.5,
                    clockwise: true)
        
        // 왼쪽 하단 모서리
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                    radius: bottomLeftRadius,
                    startAngle: .pi * 0.5,
                    endAngle: .pi,
                    clockwise: true)
        
        // 왼쪽 상단 모서리
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                    radius: topLeftRadius,
                    startAngle: .pi,
                    endAngle: .pi * 1.5,
                    clockwise: true)
        
        // 경로를 닫음
        path.close()
        
        return Path(path.cgPath)
    }
}
