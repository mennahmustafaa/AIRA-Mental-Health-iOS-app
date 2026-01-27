//
//  ChatMessage.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation

enum ChatRole: String, Codable {
    case user
    case assistant
    case system
}

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let role: ChatRole
    let timestamp: Date
    
    var isUser: Bool {
        return role == .user
    }
    
    init(id: UUID = UUID(), text: String, role: ChatRole, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.role = role
        self.timestamp = timestamp
    }
    
    // Convenience init for backward compatibility or simple usage
    init(id: UUID = UUID(), text: String, isUser: Bool, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.role = isUser ? .user : .assistant
        self.timestamp = timestamp
    }
}
