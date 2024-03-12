//
//  TeaInfo.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 10.03.24.
//

import Foundation

struct TeaInfo {
    var teaName: String
    var teaImageName: String
    var teaProperties: [TeaPropertySection]
}

struct TeaPropertySection: Identifiable {
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


struct TeaProperty: Identifiable {
    var id = UUID()
    var name: String
    var iconName: String
}
