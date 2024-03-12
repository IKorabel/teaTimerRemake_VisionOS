//
//  TeaAboutViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 10.03.24.
//

import Foundation
import SwiftUI

class TeaAboutViewModel: TeaAboutViewModelFeature.viewModelType {
    
    var teaInfo: TeaInfo
    let spacing: CGFloat = 10
    let numberOfRows = 3
    
    var isVisionOS: Bool {
        #if os(visionOS) 
        return true
        #else
        return false
        #endif
    }
    
    init(teaInfo: TeaInfo) {
        self.teaInfo = teaInfo
        super.init(state: .init())
    }
}
