//
//  BreathingExerciseView.swift
//  AIRA
//
//  Created by Mennah on 23/11/2025.
//

import SwiftUI
import AVKit

struct BreathingExerciseView: View {
    @StateObject private var viewModel = BreathingExerciseViewModel()
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND GRADIENT
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(hex: "F5F1ED"),
                    Color(hex: "E8E3DD")
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            // MARK: - VIDEO BACKGROUND
            VideoPlayerView(player: viewModel.videoPlayer)
                .ignoresSafeArea()
                .opacity(viewModel.videoOpacity)
            
            // MARK: - EDGE FADE OVERLAYS
            // Top edge fade
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "F5F1ED"), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 100)
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .opacity(viewModel.videoOpacity)
            
            // Bottom edge fade
            LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color(hex: "F5F1ED")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 100)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .opacity(viewModel.videoOpacity)
            
            // Left edge fade
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "F5F1ED"), Color.clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 80)
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea()
            .opacity(viewModel.videoOpacity)
            
            // Right edge fade
            LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color(hex: "F5F1ED")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 80)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .ignoresSafeArea()
            .opacity(viewModel.videoOpacity)
            
            VStack(spacing: 0) {
                // MARK: - LOGO
                Image("Aira")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 168, height: 49)
                    .padding(.top, 60)
                
                Spacer()
                
                // MARK: - MAIN CONTENT
                VStack(spacing: 40) {
                    // Heading Text
                    Text(viewModel.headingText)
                        .font(.custom(Fonts.primary, size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)                    
                    // MARK: - BREATHING TEXT
                    Text(viewModel.currentPhaseText)
                        .font(.custom(Fonts.primary, size: 20))
                        .foregroundColor(.black)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.currentPhaseText)
                    
                    // MARK: - PROGRESS BAR
                    if viewModel.showProgressBar {
                        VStack(spacing: 8) {
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    // Background
                                    Capsule()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 8)
                                    
                                    // Progress
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(hex: "FFB366"),
                                                    Color(hex: "FF9F4D")
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: geometry.size.width * viewModel.progress, height: 8)
                                        .animation(.linear(duration: 0.05), value: viewModel.progress)
                                }	
                            }
                            .frame(height: 8)
                            .padding(.horizontal, 40)
                        }
                    }
                }
                
                Spacer()
                
                // MARK: - SKIP BUTTON
                HStack {
                    Spacer()
                    
                    Button(action: {
                        viewModel.skipExercise()
                    }) {
                        Text("Skip")
                            .font(.custom(Fonts.primary, size: 16))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            viewModel.startBreathing()
        }
        .onDisappear {
            viewModel.stopBreathing()
        }
        .fullScreenCover(isPresented: $viewModel.shouldNavigateToNext) {
            ContentView()
        }
    }
}

#Preview {
    BreathingExerciseView()
}
