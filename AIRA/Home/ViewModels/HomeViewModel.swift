//
//  HomeViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var userName: String = "Nour"
    @Published var currentDate: Date = Date()
    @Published var streakDays: [Date] = []
    @Published var isRecording: Bool = false
    
    init() {
        generateMockStreak()
    }
    
    func generateMockStreak() {
        let calendar = Calendar.current
        let today = Date()
        
        // Generate last 7 days
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                streakDays.append(date)
            }
        }
        streakDays.reverse()
    }
    
    func startSpeaking() {
        isRecording.toggle()
        // Implement recording logic here
        print("Start speaking tapped")
    }
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good Morning" }
        if hour < 18 { return "Good Afternoon" }
        return "Good Evening"
    }
}
