//
//  AiraLogoView.swift
//  AIRA
//
//  Created by Mennah on 10/10/2025.
//

import SwiftUI

struct AiraLogoView: View {
    var size: CGFloat = 30
    var fontSize: CGFloat = 8
    
    var body: some View {
        Circle()
            .stroke(Color.orange, lineWidth: 1)
            .background(Circle().fill(Color.white))
            .frame(width: size, height: size)
            .overlay(
                Text("AIRA")
                    .font(.system(size: fontSize, weight: .bold, design: .serif))
                    .foregroundColor(.orange)
            )
            .accessibilityLabel("Aira Logo")
    }
}

#Preview {
    AiraLogoView()
}
