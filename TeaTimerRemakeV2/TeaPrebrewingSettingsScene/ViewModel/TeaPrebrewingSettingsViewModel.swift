//
//  TeaPrebrewingSettingsViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

@Observable
class TeaPrebrewingSettingsViewModel: TeaPrebrewingSettingsFeature.viewModel {
    
    var teaBrewingWays: [TeaBrewingWay]
    
    init(teaBrewingWays: [TeaBrewingWay]) {
        self.teaBrewingWays = teaBrewingWays
        super.init(state: .init())
        state.selectedOptionId = teaBrewingWays.first(where: {$0.brewingMode == .ceremony})?.id
    }
    
    override func handleViewAction(_ action: TeaPrebrewingSettingsFeature.ViewAction) {
        switch action {
        case .didSelectOption(let selectedOptionId):
            selectOption(selectedOptionId: selectedOptionId)
        }
    }
    
    func getSettingsOptions() {
        
    }
    
    func isOptionSelected(settingsOption: TeaBrewingWay) -> Bool {
        guard let selectedOptionId = state.selectedOptionId else { return false }
        return settingsOption.id == selectedOptionId
    }
    
    func getSelectedOption() -> [TeaBrewingPhase] {
        let selectedOption = teaBrewingWays.first(where: {$0.id == state.selectedOptionId})
        return selectedOption!.brewingModesWithPhases
    }
    
    private func selectOption(selectedOptionId: TeaBrewingWay.ID) {
        self.state.selectedOptionId = selectedOptionId
    }
}
