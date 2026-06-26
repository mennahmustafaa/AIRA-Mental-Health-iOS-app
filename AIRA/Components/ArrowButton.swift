//
//  ArrowButton.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct ArrowButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("ArrowNext")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.35), lineWidth: 1)
                        )
                )
        }
    }
}

#Preview {
    ZStack {
        Color.black
        ArrowButton(action: {})
    }
}



