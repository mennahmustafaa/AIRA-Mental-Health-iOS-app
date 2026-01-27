//
//  VideoPlayerService.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import AVKit
import Combine

/// Service responsible for loading and managing video players
/// Follows MVVM pattern by separating business logic from ViewModels
class VideoPlayerService {
    static let shared = VideoPlayerService()
    
    private var playerCache: [String: AVPlayer] = [:]
    
    private init() {}
    
    /// Loads a video from an asset name and returns an AVPlayer
    /// - Parameter assetName: The name of the video asset in Assets.xcassets
    /// - Returns: An optional AVPlayer instance
    func loadVideo(assetName: String) -> AVPlayer? {
        // Check cache first
        if let cachedPlayer = playerCache[assetName] {
            return cachedPlayer
        }
        
        guard let dataAsset = NSDataAsset(name: assetName) else {
            print("Error: Could not find video asset named '\(assetName)'")
            return nil
        }
        
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("\(assetName).mp4")
        
        do {
            try dataAsset.data.write(to: tempURL)
            let player = AVPlayer(url: tempURL)
            
            // Setup loop notification
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                player.play()
            }
            
            // Cache the player
            playerCache[assetName] = player
            
            return player
        } catch {
            print("Error loading video: \(error)")
            return nil
        }
    }
    
    /// Clears the player cache (useful for memory management)
    func clearCache() {
        playerCache.removeAll()
    }
}



