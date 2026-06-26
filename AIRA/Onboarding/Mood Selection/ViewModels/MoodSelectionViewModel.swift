//
//  MoodSelectionViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI

enum Mood: Int, CaseIterable {
    case happy = 0
    case excited
    case neutral
    case stressed
    case sad
    
    var emoji: String {
        switch self {
        case .happy: return "😃"
        case .excited: return "🤩"
        case .neutral: return "😐"
        case .stressed: return "😰"
        case .sad: return "😔"
        }
    }
    
    var title: String {
        switch self {
        case .happy: return "Happy"
        case .excited: return "Excited"
        case .neutral: return "Neutral"
        case .stressed: return "Stressed"
        case .sad: return "Sad"
        }
    }
    
    var description: String {
        switch self {
        case .happy: return "Light and positive"
        case .excited: return "Full of energy"
        case .neutral: return "Just okay"
        case .stressed: return "Overwhelmed"
        case .sad: return "Feeling down"
        }
    }
}

class MoodSelectionViewModel: ObservableObject {
    @Published var selectedMoodIndex: Double = 0.0 // Default to Happy (index 0)
    @Published var shouldNavigateToNext: Bool = false
    
    var currentMood: Mood {
        let index = Int(round(selectedMoodIndex))
        return Mood(rawValue: index) ?? .happy
    }
    
    func navigateToNext() {
        // Here you would typically save the selected mood
        print("Selected Mood: \(currentMood.title)")
        shouldNavigateToNext = true
    }
}
