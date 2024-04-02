//
//  TeaInfo.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 10.03.24.
//

import Foundation

protocol HashableCodable: Codable, Hashable, Equatable {
    
}

struct TeaInfo: Identifiable, HashableCodable {
    var id: UUID = UUID()
    var teaName: String
    var teaImageName: String
    var teaProperties: [TeaPropertySection]
    var teaBrewingPhases: [TeaBrewingPhase]
    
    static func == (lhs: TeaInfo, rhs: TeaInfo) -> Bool {
        return lhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TeaPropertySection: Identifiable, Codable {
    var id = UUID()
    var sectionName: String?
    var teaProperties: [TeaProperty]
    
    init(section: TeaPropertySection, teaProperties: [TeaProperty]) {
        self.sectionName = section.sectionTitle
        self.teaProperties = teaProperties
    }
    
    enum TeaPropertySection {
        case main, power, health, recomendations, taste
        
        var sectionTitle: String? {
            switch self {
            case .main:
                return nil
            case .power:
                return "Condition"
            case .health:
                return "Health"
            case .recomendations:
                return "Recomendations"
            case .taste:
                return "Taste"
            }
        }
    }
}


struct TeaProperty: Identifiable, Codable {
    var id = UUID()
    var name: String
    var iconName: String
}
