//
//  TTButton.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation
import SwiftUI


struct TTButton: ButtonStyle {
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            .foregroundStyle(.white)
            .background(backgroundColor)
            .cornerRadius(20)
            .controlSize(.large)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
