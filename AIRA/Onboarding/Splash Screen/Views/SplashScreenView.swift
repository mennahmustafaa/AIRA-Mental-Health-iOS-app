//
//  SplashScreenView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = SplashScreenViewModel()
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Background
            Color(.systemBackground)
                .ignoresSafeArea()
            
            // App Logo
            // Note: Add "AppLogo" image to Assets.xcassets
            // If image is missing, a system icon will be used as fallback
            Group {
                if let uiImage = UIImage(named: "Aira") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    // Fallback: use system app icon
                    Image(systemName: "app.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.accentColor)
                }
            }
            .frame(width: 150, height: 150)
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            // Fade-in animation
            withAnimation(.easeOut(duration: 0.8)) {
                scale = 1.0
                opacity = 1.0
            }
            
            // Start timer to dismiss splash screen
            viewModel.startTimer()
        }
        .fullScreenCover(isPresented: $viewModel.shouldDismiss) {
            WelcomeView()
        }
    }
}

#Preview {
    SplashScreenView()
}

