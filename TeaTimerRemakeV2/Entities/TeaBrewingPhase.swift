//
//  TeaBrewingPhase.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation


struct TeaBrewingWay: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var brewingMode: BrewingMode
    var brewingModesWithPhases: [TeaBrewingPhase]
    
    static func == (lhs: TeaBrewingWay, rhs: TeaBrewingWay) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
           return hasher.combine(id)
    }

}

struct TeaBrewingPhase: Identifiable, Hashable, Equatable, Codable {
    
    static func == (lhs: TeaBrewingPhase, rhs: TeaBrewingPhase) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    var phaseName: String
    var phaseDescription: String
    var phaseDuration: TimeInterval // In seconds
    var shouldShowTick: Bool
    var guidePages: [TeaBrewingGuidePage]
    var isGuideCompleted: Bool = false
    
    static let mockBrewingPhases = [TeaBrewingPhase(phaseName: "First phase", phaseDescription: "Put your leaf down", phaseDuration: 20, shouldShowTick: false, guidePages: [.mockPage, .mockPage, .mockPage]), TeaBrewingPhase(phaseName: "Second phase", phaseDescription: "Put your leaf down", phaseDuration: 40, shouldShowTick: true, guidePages: [.init(name: "Test", description: "test test", symbol: "tree.fill")])]
}

struct TeaBrewingGuidePage: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var symbol: String
    
    static let mockPage = TeaBrewingGuidePage(name: "Brewing", description: "brew brew brew", symbol: "leaf.fill")
}
