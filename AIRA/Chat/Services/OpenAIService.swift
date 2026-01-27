//
//  OpenAIService.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation

class OpenAIService {
    static let shared = OpenAIService()
    
    private let apiKey = "YOUR_OPENAI_API_KEY" // Placeholder
    
    private init() {}
    
    // Mock function to simulate mood detection
    func detectMood(from text: String) async -> String {
        // In a real app, this would call OpenAI with a specific prompt to classify emotion.
        // For now, we use simple keyword matching or random for demo.
        let lowercased = text.lowercased()
        if lowercased.contains("happy") || lowercased.contains("good") || lowercased.contains("great") { return "happy" }
        if lowercased.contains("sad") || lowercased.contains("cry") || lowercased.contains("bad") { return "sad" }
        if lowercased.contains("anxious") || lowercased.contains("worry") || lowercased.contains("scared") { return "anxious" }
        if lowercased.contains("stress") || lowercased.contains("busy") || lowercased.contains("overwhelmed") { return "stressed" }
        if lowercased.contains("excite") || lowercased.contains("wow") { return "excited" }
        
        return "neutral"
    }
    
    // Mock function to simulate response generation
    func getResponse(messages: [ChatMessage], systemPrompt: String) async throws -> String {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // In a real app, this would construct the JSON payload and call https://api.openai.com/v1/chat/completions
        
        // For the mock, we just return a generic response based on the system prompt's "vibe"
        // We can check the system prompt to see which mood it corresponds to roughly
        
        if systemPrompt.contains("happy") {
            return "That's wonderful to hear! Keeping that positive energy flowing is so important. What's the best part of your day so far? 😊"
        } else if systemPrompt.contains("sad") {
            return "I hear you, and I want you to know that your feelings are valid. Take your time. I'm here to listen if you want to share more. 💙"
        } else if systemPrompt.contains("anxious") {
            return "It sounds like things are a bit heavy right now. Let's take a moment. Can you name three things you see around you? It helps to ground us. 🌿"
        } else if systemPrompt.contains("stressed") {
            return "I can sense the pressure you're under. Remember, you don't have to solve everything at once. Let's just take one deep breath together. 🌬️"
        } else {
            return "I'm listening. Tell me more about what's on your mind. I'm here to support you."
        }
    }
}
