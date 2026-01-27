//
//  BaseOnboardingViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI
import AVKit

/// Base ViewModel for onboarding screens that use video backgrounds
/// Follows MVVM pattern by providing common functionality
class BaseOnboardingViewModel: ObservableObject {
    @Published var player: AVPlayer?
    
    private let videoService = VideoPlayerService.shared
    
    /// Loads a video using the shared video service
    /// Override in subclasses if custom behavior is needed
    func loadVideo(assetName: String) {
        player = videoService.loadVideo(assetName: assetName)
    }
}



