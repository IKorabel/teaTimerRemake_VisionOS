//
//  TeaBrewingFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation
import SwiftUI

struct TeaBrewingFeature {
    typealias viewModel = ViewModel<State, ViewAction, CallbackAction>
    
    enum ViewAction {
        case didClickOnPlayButton
        case didClickOnPauseButton
        case didClickOnGoNextButton
        case didClickOnGoBackButton
        case didClickOnNextGuidePageButton(withTabIndex: Int, dismissAction: DismissAction)
        case didClickOnSkipManualButton
    }
    
    enum CallbackAction {
        case goToNextStage
        case goToPreviousStage
    }
}
