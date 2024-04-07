//
//  ButtonModifiers.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.04.24.
//

import Foundation
import SwiftUI


extension Button {
    
    func makeCircularButton(isVisionOS: Bool) -> some View {
        self
          .buttonStyle(!isVisionOS ? .borderedProminent : .init())
          .buttonBorderShape(!isVisionOS ? .capsule: .automatic)
          .tint(!isVisionOS ? Color.white : Color.init(.systemBackground))
          .foregroundStyle(!isVisionOS ? Color.ttGreen : Color.primary)
          .controlSize(.large)
          .font(.title)
    }
}
