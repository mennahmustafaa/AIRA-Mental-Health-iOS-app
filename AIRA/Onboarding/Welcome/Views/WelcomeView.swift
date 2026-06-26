
//
//  Created by Mennah on 10/10/2025.
//
//
//  FirstOnboardingScreen.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

//
//  WelcomeView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI
import AVKit

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var logoOffset: CGFloat = 300
    @State private var logoScale: CGFloat = 1.0
    @State private var logoOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            
            // MARK: - VIDEO BACKGROUND
            if let player = viewModel.player {
                VideoPlayerView(player: player)
                    .ignoresSafeArea()
            } else {
                ProgressView()
            }
            
            // MARK: - LOGO ANIMATION
            VStack {
                Image("Aira")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 168, height: 49)
                    .offset(y: logoOffset)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                
                Spacer()
            }
            .padding(.top, 60)
            
            // MARK: - TEXT + ARROW + PROGRESS
            VStack {
                Spacer()
                
                HStack(alignment: .top) {
                    
                    // TEXT
                    Text("Welcome to your personal\ncalm space")
                        .font(.custom(Fonts.primary, size: 24)) // Use Fonts.primary
                        .foregroundColor(.white)
                        .frame(width: 287, alignment: .leading)
                        .offset(y:-35)
                    
                    // ARROW BUTTON (GLASS) - Reusable component
                    ArrowButton(action: { viewModel.navigateToMain() })
                        .offset(y:45)
                }
                
                // PROGRESS INDICATORS
                HStack(spacing: 8) {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 24, height: 8)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 24, height: 8)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 24, height: 8)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            viewModel.loadVideo()
            
            // LOGO ANIMATION
            withAnimation(.easeOut(duration: 1.3)) {
                logoOffset = 0
            }
        }
        .fullScreenCover(isPresented: $viewModel.shouldNavigateToMain) {
            GoalSelectionView()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    WelcomeView()
}




