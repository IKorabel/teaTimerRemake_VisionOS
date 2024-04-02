//
//  TeaBrewingTimerFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation

struct TeaBrewingTimerFeature {
    typealias viewModel = ViewModel<State, ViewAction, CallbackAction>
    
    struct State {
        var remainingTime: TimeInterval
        var isTimerActive: Bool
        var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        init(duration: TimeInterval, isTimerActive: Bool) {
            self.remainingTime = duration
            self.isTimerActive = isTimerActive
        }
    }
    
    enum ViewAction {
        case didClickOnPlayButton
        case didClickOnPauseButton
        case didClickOnGoNextButton
        case didClickOnGoBackButton
    }
    
    enum CallbackAction {
        case goToNextStage
        case goToPreviousStage
    }
}
