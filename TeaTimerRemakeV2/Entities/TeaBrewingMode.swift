//
//  TeaBrewingMode.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

enum BrewingMode: TeaSettings, CaseIterable, Codable {
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
        switch self {
        case .ceremony:
            return "teaCeremony1"
        case .kettle:
            return "teaGlassBrewing"
        case .teaBag:
            return "teaCup"
        }
    }
    
    var modeDescription: String {
        return "Way of brewing a tea"
    }
    
}
