//
//  TeaPrebrewingSettingsFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 28.03.24.
//

import Foundation

struct TeaPrebrewingSettingsFeature {
    typealias viewModel = ViewModel<State, ViewAction, CallbackAction>
    
    enum ViewAction {
        case didSelectOption(optionId: TeaBrewingWay.ID)
    }
    
    enum CallbackAction {
        
    }
}
