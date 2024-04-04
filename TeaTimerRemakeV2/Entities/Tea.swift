//
//  Tea.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 10.03.24.
//
import SwiftUI
import Foundation

struct Tea: Identifiable {
    var id = UUID()
    var name: String
    var bgColor: Color
    var teaInformation: TeaInfo
    var brewingWays: [TeaBrewingWay]
    
    init(tea: TeaKind) {
        self.name = tea.tea.name
        self.teaInformation = tea.tea.teaInformation
        self.bgColor = tea.tea.bgColor
        self.brewingWays = tea.brewingWays
    }
    
    internal init(name: String, bgColor: Color, teaInformation: TeaInfo, brewingWays: [TeaBrewingWay]) {
        self.name = name
        self.bgColor = bgColor
        self.teaInformation = teaInformation
        self.brewingWays = brewingWays
    }
    
    
    static let teaList: [Tea] = [.init(tea: .shuPuerh), .init(tea: .shengPuerh)]
}

extension Tea {
    
    enum TeaKind {
        case shuPuerh, shengPuerh
        
        var brewingWays: [TeaBrewingWay] {
            switch self {
            case .shuPuerh:
                return [TeaBrewingWay(brewingMode: .ceremony, brewingModesWithPhases: TeaBrewingPhase.mockBrewingPhases),
                        TeaBrewingWay(brewingMode: .kettle, brewingModesWithPhases: TeaBrewingPhase.mockBrewingPhases)]
            case .shengPuerh:
                return [TeaBrewingWay(brewingMode: .ceremony, brewingModesWithPhases: TeaBrewingPhase.mockBrewingPhases),
                        TeaBrewingWay(brewingMode: .kettle, brewingModesWithPhases: TeaBrewingPhase.mockBrewingPhases)]
            }
        }
        
        var tea: Tea {
            switch self {
            case .shuPuerh:
                return Tea(name: "Shu Puerh", bgColor: .ttGreen, 
                           teaInformation: .init(teaName: "Shu Puerh", teaImageName: "",
                            teaProperties: [
                                  TeaPropertySection(section: .main,
                                                     teaProperties: [
                                      .init(name: "Mainland, China", iconName: "mappin.circle.fill"),
                                      .init(name: "Morning", iconName: "sunrise.fill"),
                                      .init(name: "Energizer", iconName: "bolt.fill")]),
                                  TeaPropertySection(section: .power,
                                                     teaProperties:
                                                      [.init(name: "Concentration", iconName: "eye.fill"),
                                                       .init(name: "Vigor", iconName: "bolt.fill")]),
                                  TeaPropertySection(section: .health, teaProperties: [
                                      .init(name: "Boosts immunity", iconName: "shield.righthalf.filled"),
                                      .init(name: "Weight Loss", iconName: "scalemass.fill"),
                                      .init(name: "Removes toxins", iconName: "pill.fill")
                                  ])],
                                    teaBrewingPhases: TeaBrewingPhase.mockBrewingPhases
                                                ), brewingWays: brewingWays)
            case .shengPuerh:
                return Tea(name: "Sheng Puerh", bgColor: .ttGreen,
                           teaInformation: .init(teaName: "Sheng Puerh", teaImageName: "",
                            teaProperties: [
                                  TeaPropertySection(section: .main,
                                                     teaProperties: [
                                      .init(name: "Mainland, China", iconName: "mappin.circle.fill"),
                                      .init(name: "Morning", iconName: "sunrise.fill"),
                                      .init(name: "Energizer", iconName: "bolt.fill")]),
                                  TeaPropertySection(section: .power,
                                                     teaProperties:
                                                      [.init(name: "Concentration", iconName: "eye.fill"),
                                                       .init(name: "Vigor", iconName: "bolt.fill")]),
                                  TeaPropertySection(section: .health, teaProperties: [
                                      .init(name: "Boosts immunity", iconName: "shield.righthalf.filled"),
                                      .init(name: "Weight Loss", iconName: "scalemass.fill"),
                                      .init(name: "Removes toxins", iconName: "pill.fill")
                                  ])],
                                    teaBrewingPhases: TeaBrewingPhase.mockBrewingPhases
                                                ), brewingWays: brewingWays)
            }
        }
    }
}

