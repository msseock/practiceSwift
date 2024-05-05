//
//  Chat.swift
//  PracticeChat
//
//  Created by 석민솔 on 5/5/24.
//

import Foundation

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
}
