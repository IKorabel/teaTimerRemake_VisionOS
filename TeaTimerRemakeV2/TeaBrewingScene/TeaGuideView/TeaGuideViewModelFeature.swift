//
//  TeaGuideViewModelFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 01.04.24.
//

import Foundation

struct TeaGuideViewModelFeature {
    typealias viewModel = ViewModel<State, ViewAction, CallbackAction>
    
    struct State {
        var selectedGuidePageTabIndex: Int = 0
    }
    
    enum ViewAction {
        case didClickOnDoneButton
        case didChangeBrewingPhase(envViewMode: TeaBrewingViewModel)
    }
    
    enum CallbackAction {
        
    }
}
