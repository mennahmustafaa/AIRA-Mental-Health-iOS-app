//
//  WelcomeViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI
import AVKit

class WelcomeViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var shouldNavigateToMain: Bool = false
    
    private let videoService = VideoPlayerService.shared
    
    func loadVideo() {
        // Use shared service to load video - prevents code duplication
        player = videoService.loadVideo(assetName: "CalmBoyFullRes")
    }
    
    func navigateToMain() {
        shouldNavigateToMain = true
    }
}
