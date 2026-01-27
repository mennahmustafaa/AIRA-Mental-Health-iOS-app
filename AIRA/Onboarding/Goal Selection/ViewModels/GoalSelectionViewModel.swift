//
//  GoalSelectionViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI
import AVKit

enum Goal: String, CaseIterable, Codable, Hashable {
    case sleep = "Sleep"
    case mindfulness = "Mindfulness"
    case stress = "Stress"
    case anxiety = "Anxiety"
    case focus = "Focus"
    case selfLove = "Self-Love"
    
    var emoji: String {
        switch self {
        case .sleep: return "😴"
        case .mindfulness: return "🧘"
        case .stress: return "😰"
        case .anxiety: return "🧠"
        case .focus: return "🎯"
        case .selfLove: return "❤️"
        }
    }
}

class GoalSelectionViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var selectedGoals: Set<Goal> = [] // Changed to Set for multiple selection
    @Published var shouldNavigateToNext: Bool = false
    @Published var showAlert: Bool = false
    
    private let videoService = VideoPlayerService.shared
    private let preferencesService = UserPreferencesService.shared
    
    init() {
        // Initialize with empty set - let user select
        selectedGoals = []
    }
    
    func loadVideo() {
        // Reuse the same video using shared service
        player = videoService.loadVideo(assetName: "CalmBoyFullRes")
    }
    
    func selectGoal(_ goal: Goal) {
        if selectedGoals.contains(goal) {
            // Deselect
            selectedGoals.remove(goal)
        } else {
            // Select if limit not reached
            if selectedGoals.count < 3 {
                selectedGoals.insert(goal)
            }
        }
    }
    
    func navigateToNext() {
        // Show alert if no goal is selected
        if selectedGoals.isEmpty {
            showAlert = true
            return
        }
        
        // Save selected goals to local storage
        preferencesService.saveSelectedGoals(selectedGoals)
        
        shouldNavigateToNext = true
    }
}



