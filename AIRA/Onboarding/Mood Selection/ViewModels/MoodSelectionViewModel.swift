//
//  MoodSelectionViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI



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
