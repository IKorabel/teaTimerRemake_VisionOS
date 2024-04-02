//
//  BlurRadiusModifier.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 01.04.24.
//

import Foundation
import SwiftUI

struct BlurRadiusModifier: AnimatableModifier {
    var blurRadius: CGFloat
    
    var animatableData: CGFloat {
        get { blurRadius }
        set { blurRadius = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .blur(radius: blurRadius)
    }
}
