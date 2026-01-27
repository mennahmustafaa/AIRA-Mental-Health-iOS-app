//
//  ChatViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var isTyping: Bool = false
    @Published var currentMood: Mood = .happy // Default, should be injected or fetched
    
    @Published var suggestedPrompts: [String] = ["Can't sleep", "I'm feeling anxious", "I'm overthinking"]
    
    @Published var suggestedPrompts: [String] = ["Can't sleep", "I'm feeling anxious", "I'm overthinking"]
    
    private let openAIService = OpenAIService.shared
    private let scriptService = ScriptService.shared
    
    init() {
        // Add initial greeting
        // addMessage(text: "Hello! I'm AIRA. How are you feeling today?", isUser: false)
    }
    
    func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        
        // Add user message
        addMessage(text: text, isUser: true)
        inputText = ""
        
        // Simulate typing and get response
        isTyping = true
        
        Task {
            do {
                // 1. Detect Mood from User Input
                let detectedMood = await openAIService.detectMood(from: text)
                print("Detected Mood: \(detectedMood)")
                
                // 2. Get Behavioral Script for Mood
                let systemPrompt = scriptService.getScript(for: detectedMood)
                print("System Prompt: \(systemPrompt)")
                
                // 3. Generate Response using System Prompt
                let response = try await openAIService.getResponse(messages: messages, systemPrompt: systemPrompt)
                
                isTyping = false
                addMessage(text: response, isUser: false)
            } catch {
                isTyping = false
                addMessage(text: "I'm having trouble connecting right now. Please try again.", isUser: false)
            }
        }
    }
    
    func sendPrompt(_ prompt: String) {
        inputText = prompt
        sendMessage()
    }
    
    private func addMessage(text: String, isUser: Bool) {
        let message = ChatMessage(text: text, isUser: isUser)
        messages.append(message)
    }
}
