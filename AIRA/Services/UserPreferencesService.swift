//
//  UserPreferencesService.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation

class UserPreferencesService {
    static let shared = UserPreferencesService()
    
    private let userDefaults = UserDefaults.standard
    private let selectedGoalsKey = "selectedOnboardingGoals"
    
    private init() {}
    
    // Save selected goals to UserDefaults
    func saveSelectedGoals(_ goals: Set<Goal>) {
        let goalStrings = goals.map { $0.rawValue }
        userDefaults.set(goalStrings, forKey: selectedGoalsKey)
    }
    
    // Retrieve selected goals from UserDefaults
    func getSelectedGoals() -> Set<Goal> {
        guard let goalStrings = userDefaults.stringArray(forKey: selectedGoalsKey) else {
            return []
        }
        
        let goals = goalStrings.compactMap { Goal(rawValue: $0) }
        return Set(goals)
    }
    
    // Clear selected goals
    func clearSelectedGoals() {
        userDefaults.removeObject(forKey: selectedGoalsKey)
    }
}
