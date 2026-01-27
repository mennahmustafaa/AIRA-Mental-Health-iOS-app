//
//  BreathingExerciseViewModel.swift
//  AIRA
//
//  Created by Mennah on 23/11/2025.
//

import Foundation
import Combine
import AVFoundation
import UIKit

// MARK: - Breathing Technique Model
enum BreathingTechnique {
    case box // 4-4-4-4: breathe in, hold, breathe out, hold
    case deep // 4-7-8: breathe in, hold, breathe out
    case calm // 4-4: breathe in, breathe out
    
    var phases: [BreathingPhase] {
        switch self {
        case .box:
            return [
                BreathingPhase(type: .breatheIn, duration: 4),
                BreathingPhase(type: .hold, duration: 4),
                BreathingPhase(type: .breatheOut, duration: 4),
                BreathingPhase(type: .hold, duration: 4)
            ]
        case .deep:
            return [
                BreathingPhase(type: .breatheIn, duration: 4),
                BreathingPhase(type: .hold, duration: 7),
                BreathingPhase(type: .breatheOut, duration: 8)
            ]
        case .calm:
            return [
                BreathingPhase(type: .breatheIn, duration: 4),
                BreathingPhase(type: .breatheOut, duration: 4)
            ]
        }
    }
}

// MARK: - Breathing Phase Model
struct BreathingPhase {
    let type: PhaseType
    let duration: TimeInterval // in seconds
    
    enum PhaseType {
        case breatheIn
        case hold
        case breatheOut
        
        var displayText: String {
            switch self {
            case .breatheIn: return "Breathe in..."
            case .hold: return "Hold..."
            case .breatheOut: return "Breathe out..."
            }
        }
    }
}

// MARK: - ViewModel
class BreathingExerciseViewModel: ObservableObject {
    @Published var headingText: String = "Let's take a moment to slow down."
    @Published var currentPhaseText: String = "Breathe in..."
    @Published var progress: Double = 1.0 // Progress from 1.0 (100%) to 0.0 (0%)
    @Published var shouldNavigateToNext: Bool = false
    @Published var isPlaying: Bool = false
    @Published var showProgressBar: Bool = true
    @Published var videoOpacity: Double = 1.0
    
    var videoPlayer: AVPlayer
    
    private var currentTechnique: BreathingTechnique = .box
    private var currentPhaseIndex: Int = 0
    private var timer: Timer?
    private var phaseStartTime: Date?
    private var cancellables = Set<AnyCancellable>()
    
    init(technique: BreathingTechnique = .box) {
        self.currentTechnique = technique
        
        // Initialize video player from dataset
        if let videoAsset = NSDataAsset(name: "BreathingVid") {
            print("✅ Video asset found, size: \(videoAsset.data.count) bytes")
            // Create temporary file URL
            let tempURL = FileManager.default.temporaryDirectory
                .appendingPathComponent("BreathingVid.mp4")
            
            do {
                try videoAsset.data.write(to: tempURL)
                self.videoPlayer = AVPlayer(url: tempURL)
                print("✅ Video player created successfully at: \(tempURL)")
                
                // Observe video end to stop breathing exercise
                NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: videoPlayer.currentItem,
                    queue: .main
                ) { [weak self] _ in
                    print("🎬 Video ended, stopping breathing exercise")
                    self?.handleVideoEnd()
                }
            } catch {
                print("❌ Error writing video to temp file: \(error)")
                self.videoPlayer = AVPlayer()
            }
        } else {
            print("❌ Video asset 'BreathingVid' not found in dataset")
            self.videoPlayer = AVPlayer()
        }
    }
    
    func startBreathing() {
        currentPhaseIndex = 0
        isPlaying = true
        startCurrentPhase()
        
        // Start video playback
        videoPlayer.play()
    }
    
    private func startCurrentPhase() {
        let phases = currentTechnique.phases
        guard currentPhaseIndex < phases.count else {
            // Cycle back to the beginning
            currentPhaseIndex = 0
            startCurrentPhase()
            return
        }
        
        let phase = phases[currentPhaseIndex]
        currentPhaseText = phase.type.displayText
        phaseStartTime = Date()
        progress = 1.0 // Reset to 100%
        
        // Invalidate previous timer
        timer?.invalidate()
        
        // Create a timer that updates every 0.05 seconds for smooth animation
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.updateProgress()
        }
    }
    
    private func updateProgress() {
        guard let startTime = phaseStartTime else { return }
        guard isPlaying else { return } // Don't update progress if not playing
        
        let phases = currentTechnique.phases
        guard currentPhaseIndex < phases.count else { return }
        
        let phase = phases[currentPhaseIndex]
        let elapsed = Date().timeIntervalSince(startTime)
        
        // Calculate progress from 1.0 to 0.0
        let newProgress = max(0.0, 1.0 - (elapsed / phase.duration))
        
        DispatchQueue.main.async { [weak self] in
            self?.progress = newProgress
            
            // Move to next phase when current phase completes
            if newProgress <= 0.0 {
                // Check if we just completed the breathe out phase
                if phase.type == .breatheOut {
                    print("🎯 Breathe out completed, ending exercise")
                    self?.handleVideoEnd()
                } else {
                    // Move to next phase
                    self?.currentPhaseIndex += 1
                    self?.startCurrentPhase()
                }
            }
        }
    }
    
    func stopBreathing() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
        videoPlayer.pause()
    }
    
    private func handleVideoEnd() {
        // Stop the breathing exercise when video ends
        stopBreathing()
        
        // Set completion message (animation will be handled in the View)
        headingText = "You are ready"
        currentPhaseText = ""
        progress = 0.0 // Set progress to complete
        showProgressBar = false // Hide progress bar
        videoOpacity = 0.0 // Fade out video
        
        // Optionally navigate to next screen after video ends
        // shouldNavigateToNext = true
    }
    
    func skipExercise() {
        stopBreathing()
        shouldNavigateToNext = true
    }
    
    deinit {
        stopBreathing()
        NotificationCenter.default.removeObserver(self)
    }
}
