//
//  ChatView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(hex: "FDF8F4") // Background Color
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - HEADER
                HStack {
                    Image("UserAvatar") // Placeholder for avatar
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.orange, lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Good Morning, Nour")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("🌞")
                        }
                        Text("A new day, a calmer you.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
                
                // MARK: - GREETING
                if viewModel.messages.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Hi, I'm Aira. your personal AI coach.")
                            .font(.headline)
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("I'm here to gently guide you through your thoughts today")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    // MARK: - SUGGESTED PROMPTS
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.suggestedPrompts, id: \.self) { prompt in
                            Button(action: {
                                viewModel.sendPrompt(prompt)
                            }) {
                                HStack {
                                    Image(systemName: "sparkles")
                                        .foregroundColor(.orange)
                                    Text(prompt)
                                        .foregroundColor(.black.opacity(0.8))
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color(hex: "FFF0E0"))
                                .cornerRadius(20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                } else {
                    // MARK: - CHAT HISTORY
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.messages) { message in
                                    MessageBubble(message: message)
                                }
                                
                                if viewModel.isTyping {
                                    HStack {
                                        Text("AIRA is typing...")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(.leading)
                                        Spacer()
                                    }
                                }
                            }
                            .padding()
                        }
                        .onChange(of: viewModel.messages.count) {
                            if let lastMessage = viewModel.messages.last {
                                withAnimation {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                // MARK: - INPUT AREA
                HStack {
                    AiraLogoView()
                    
                    TextField("Tell Aira how you feel", text: $viewModel.inputText)
                        .padding(.leading, 5)
                        .onSubmit {
                            viewModel.sendMessage()
                        }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
                .padding()
                
                // Keyboard spacer
                Spacer()
                    .frame(height: 10)
            }
            
            // Back Button (Hidden but functional if needed, or rely on swipe)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ChatView()
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .cornerRadius(2, corners: .bottomRight)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(16)
                    .cornerRadius(2, corners: .bottomLeft)
                    .shadow(radius: 1)
                Spacer()
            }
        }
    }
}
