//
//  GoalSelectionView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI
import AVKit

struct GoalSelectionView: View {
    @StateObject private var viewModel = GoalSelectionViewModel()
    
    var body: some View {
        ZStack {
            // MARK: - REUSABLE VIDEO BACKGROUND
            if let player = viewModel.player {
                VideoPlayerView(player: player)
                    .ignoresSafeArea()
            } else {
                ProgressView()
            }
            
            VStack(spacing: 0) {
                // MARK: - LOGO
                Image("Aira")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 168, height: 49)
                    .padding(.top, 60)
                
                Spacer()
                
                // MARK: - GOAL SELECTION SECTION
                VStack(alignment: .leading, spacing: 20) {
                    // Prompt Text
                    Text("Pick your goal")
                        .font(.custom(Fonts.primary, size: 24))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    
                    // Goal Buttons Grid
                    VStack(spacing: 2) {
                        // Top Row
                        HStack(spacing: 12) {
                            GoalButton(
                                emoji: Goal.sleep.emoji,
                                title: Goal.sleep.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.sleep),
                                action: { viewModel.selectGoal(.sleep) }
                            )
                            
                            GoalButton(
                                emoji: Goal.mindfulness.emoji,
                                title: Goal.mindfulness.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.mindfulness),
                                action: { viewModel.selectGoal(.mindfulness) }
                            )
                        }
                        
                        // Middle Row
                        HStack(spacing: 12) {
                            GoalButton(
                                emoji: Goal.stress.emoji,
                                title: Goal.stress.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.stress),
                                action: { viewModel.selectGoal(.stress) }
                            )
                            
                            GoalButton(
                                emoji: Goal.anxiety.emoji,
                                title: Goal.anxiety.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.anxiety),
                                action: { viewModel.selectGoal(.anxiety) }
                            )
                        }
                        
                        // Bottom Row
                        HStack(spacing: 12) {
                            GoalButton(
                                emoji: Goal.focus.emoji,
                                title: Goal.focus.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.focus),
                                action: { viewModel.selectGoal(.focus) }
                            )
                            
                            	GoalButton(
                                emoji: Goal.selfLove.emoji,
                                title: Goal.selfLove.rawValue,
                                isSelected: viewModel.selectedGoals.contains(.selfLove),
                                action: { viewModel.selectGoal(.selfLove) }
                            )
                        }
                    }
                  .padding(.horizontal, 20)
//                    .padding(.top, 30)
                    
                    Spacer()
                    
                    // MARK: - BOTTOM SECTION (Progress + Arrow)
                    HStack {
                        // Progress Indicators
                        HStack(spacing: 8) {
                            Capsule()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 32, height: 8)
                            
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 32, height: 8)
                            
                            Spacer()
                        }
                        
                        // MARK: - REUSABLE ARROW BUTTON
                        ArrowButton(action: { viewModel.navigateToNext() })
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
                
            }
        }
        .onAppear {
            viewModel.loadVideo()
        }
        .fullScreenCover(isPresented: $viewModel.shouldNavigateToNext) {
            BreathingExerciseView()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Selection Required"),
                message: Text("Please select at least one goal to continue."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    GoalSelectionView()
}



