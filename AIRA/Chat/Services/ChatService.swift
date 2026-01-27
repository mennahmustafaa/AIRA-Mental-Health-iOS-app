//
//  ChatService.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation

protocol ChatServiceProtocol {
    func sendMessage(text: String, mood: Mood) async throws -> String
}

class MockChatService: ChatServiceProtocol {
    
    func sendMessage(text: String, mood: Mood) async throws -> String {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return generateResponse(for: text, mood: mood)
    }
    
    private func generateResponse(for text: String, mood: Mood) -> String {
        let lowercasedText = text.lowercased()
        
        // Basic mood-based responses
        switch mood {
        case .happy:
            if lowercasedText.contains("hello") || lowercasedText.contains("hi") {
                return "Hello! It's great to see you feeling happy today! 😊 How can I keep this positive vibe going?"
            } else {
                return "That sounds wonderful! Tell me more about it! 🌟"
            }
        case .excited:
            return "Wow! Your energy is contagious! 🤩 What's got you so excited?"
        case .neutral:
            return "I hear you. Sometimes a neutral day is just what we need. 😐 How can I help you today?"
        case .stressed:
            return "I'm sorry to hear you're feeling stressed. 😰 Remember to take deep breaths. I'm here to listen."
        case .sad:
            return "I'm sending you a virtual hug. 😔 It's okay to feel sad. I'm here for you."
        }
    }
}
