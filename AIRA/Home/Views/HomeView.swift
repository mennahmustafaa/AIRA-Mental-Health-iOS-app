//
//  HomeView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showChat = false
    
    var body: some View {
        ZStack {
            Color(hex: "FDF8F4") // Background Color
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
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
                            Text("\(viewModel.greeting), \(viewModel.userName)")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("🌞") // Placeholder emoji
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
                
                // MARK: - CALENDAR STRIP
                HStack(spacing: 15) {
                    ForEach(viewModel.streakDays, id: \.self) { date in
                        VStack(spacing: 8) {
                            Text(date.formatted(.dateTime.weekday(.abbreviated)).prefix(1))
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text(date.formatted(.dateTime.day()))
                                .font(.subheadline)
                                .fontWeight(Calendar.current.isDateInToday(date) ? .bold : .regular)
                                .foregroundColor(Calendar.current.isDateInToday(date) ? .white : .black)
                                .frame(width: 30, height: 30)
                                .background(Calendar.current.isDateInToday(date) ? Color.black : Color.clear)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - ORB
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(hex: "FFF0E0"), Color(hex: "FFE0B2")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 250, height: 250)
                        .shadow(color: Color.orange.opacity(0.3), radius: 20, x: 0, y: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                        )
                    
                    Text("AIRA")
                        .font(.custom("Didot", size: 40)) // Using a serif font to match the image
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Text("Hi, I'm Aira. your personal AI coach.")
                    .font(.headline)
                    .foregroundColor(.black.opacity(0.8))
                
                Text("I'm here to gently guide you through your thoughts today")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                // MARK: - START SPEAKING BUTTON
                Button(action: {
                    viewModel.startSpeaking()
                }) {
                    HStack {
                        Text("Start Speaking")
                            .font(.headline)
                        Image(systemName: "mic")
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .background(Color(hex: "D97706")) // Dark Orange
                    .cornerRadius(30)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // MARK: - BOTTOM BAR
                HStack {
                    Spacer()
                    Image(systemName: "house")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                    Spacer()
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "person")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                    Spacer()
                    
                    // Message Button
                    Button(action: {
                        showChat = true
                    }) {
                        Image(systemName: "message") // Chat icon
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .padding(12)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
            }
        }
        .fullScreenCover(isPresented: $showChat) {
            ChatView()
        }
    }
}

#Preview {
    HomeView()
}
