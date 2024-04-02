//
//  TeaBrewingMode.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

extension TeaBrewingMode {
    
    enum BrewingMode: TeaSettings, CaseIterable {
        case ceremony, kettle, teaBag
        
        var modeTitle: String {
            switch self {
            case .ceremony:
                return "Ceremony"
            case .kettle:
                return "Kettle"
            case .teaBag:
                return "Tea bag"
            }
        }
        
        var imageName: String {
            return "starSky"
        }
        
        var modeDescription: String {
            return "Way of brewing a tea"
        }
        
    }
    
}
