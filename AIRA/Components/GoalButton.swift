//
//  GoalButton.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct GoalButton: View {
    let emoji: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(emoji)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.custom(Fonts.primary, size: 16))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.white.opacity(0.9) : Color.white.opacity(0.7))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
            )
        }
    }
}

#Preview {
    ZStack {
        Color.blue
        VStack(spacing: 12) {
            GoalButton(emoji: "😴", title: "Sleep", isSelected: false, action: {})
            GoalButton(emoji: "🧘", title: "Mindfulness", isSelected: true, action: {})
        }
        .padding()
    }
}



