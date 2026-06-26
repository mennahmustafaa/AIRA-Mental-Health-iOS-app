//
//  MoodSelectionView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct MoodSelectionView: View {
    @StateObject private var viewModel = MoodSelectionViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(hex: "FFFBF5")
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image("Aira")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 168, height: 49)
                        Spacer()
                    }
                    
                    Spacer().frame(height: 40)
                    
                    Text("How are you feeling right now?")
                        .font(.custom(Fonts.primary, size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.bold)
                    
                    Text("Just a quick check-in to personalize your journey")
                        .font(.custom(Fonts.primary, size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                Spacer()
                
                // Mood Display
                VStack(spacing: 16) {
                    Text(viewModel.currentMood.emoji)
                        .font(.system(size: 80))
                    
                    Text(viewModel.currentMood.title)
                        .font(.custom(Fonts.primary, size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text(viewModel.currentMood.description)
                        .font(.custom(Fonts.primary, size: 16))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Slider Section
                VStack(spacing: 20) {
                    ZStack {
                        // Custom Slider Track
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.orange.opacity(0.1))
                                    .frame(height: 8)
                                
                                // Dots
                                HStack(spacing: 0) {
                                    ForEach(0..<Mood.allCases.count, id: \.self) { index in
                                        Circle()
                                            .fill(Color.orange.opacity(0.3))
                                            .frame(width: 8, height: 8)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                        .frame(height: 8)
                        
                        // Actual Slider
                        Slider(value: $viewModel.selectedMoodIndex, in: 0...Double(Mood.allCases.count - 1), step: 1)
                            .accentColor(.orange)
                            .opacity(0.05)
                    }
                    .overlay(
                        // Custom Thumb Position
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let count = CGFloat(Mood.allCases.count - 1)
                            let stepWidth = width / count
                            let xOffset = CGFloat(viewModel.selectedMoodIndex) * stepWidth
                            
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 24, height: 24)
                                .position(x: xOffset, y: geometry.size.height / 2)
                                .allowsHitTesting(false)
                        }
                    )
                    .padding(.horizontal, 40)
                    
                    Text("Mood picker")
                        .font(.custom(Fonts.primary, size: 16))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                // Footer
                VStack(spacing: 16) {
                    // Progress Indicators
                    HStack(spacing: 8) {
                        Capsule()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 24, height: 8)
                        
                        Capsule()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 24, height: 8)
                        
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 24, height: 8)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    HStack {
                        Spacer()
                        
                        // Custom Arrow Button
                        Button(action: {
                            viewModel.navigateToNext()
                        }) {
                            HStack(alignment: .top, spacing: 0) {
                                Image("ArrowNext")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(Color.black)
                            )
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $viewModel.shouldNavigateToNext) {
            BreathingExerciseView()
        }
    }
}

#Preview {
    MoodSelectionView()
}
