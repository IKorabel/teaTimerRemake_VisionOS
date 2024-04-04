//
//  ImmersiveTeaBrewingBackground.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 04.04.24.
//

import Foundation

enum ImmersiveTeaBrewingBackground {
    case cyberpunk
    case mountains
    case chineseHouse
    
    var assetName: String {
        switch self {
        case .cyberpunk:
            return "cyberpunkInter"
        case .mountains:
            return "mountainsInter"
        case .chineseHouse:
            return "chineseInter"
        }
    }
}
