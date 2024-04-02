//
//  TeaPrebrewingSettings.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

struct TeaPrebrewingSettings {
    var brewingMode: TeaBrewingMode
}

struct TeaBrewingMode: Identifiable {
    let id = UUID()
    let brewingMode: BrewingMode
    
    static let allBrewingModes: [TeaBrewingMode] = [.init(brewingMode: .ceremony), .init(brewingMode: .kettle), .init(brewingMode: .teaBag)]
    
}
