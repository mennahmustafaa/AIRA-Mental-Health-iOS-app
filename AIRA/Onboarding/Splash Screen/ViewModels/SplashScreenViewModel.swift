//
//  SplashScreenViewModel.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import Foundation
import SwiftUI

class SplashScreenViewModel: ObservableObject {
    @Published var shouldDismiss: Bool = false
    
    private var timer: Timer?
    
    func startTimer() {
        // Show splash screen for 2 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            DispatchQueue.main.async {
                withAnimation {
                    self?.shouldDismiss = true
                }
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

