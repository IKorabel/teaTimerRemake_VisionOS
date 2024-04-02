//
//  TeaPrebrewingSettingsViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

@Observable
class TeaPrebrewingSettingsViewModel: TeaPrebrewingSettingsFeature.viewModel {
    
    var settingOptions: [TeaBrewingMode] = TeaBrewingMode.allBrewingModes
    
    init() {
        super.init(state: .init())
        state.selectedOptionId = settingOptions.first(where: {$0.brewingMode == .ceremony})?.id
    }
    
    override func handleViewAction(_ action: TeaPrebrewingSettingsFeature.ViewAction) {
        switch action {
        case .didSelectOption(let selectedOptionId):
            selectOption(selectedOptionId: selectedOptionId)
        }
    }
    
    func isOptionSelected(settingsOption: TeaBrewingMode) -> Bool {
        guard let selectedOptionId = state.selectedOptionId else { return false }
        return settingsOption.id == selectedOptionId
    }
    
    private func selectOption(selectedOptionId: TeaBrewingMode.ID) {
        self.state.selectedOptionId = selectedOptionId
    }
}
