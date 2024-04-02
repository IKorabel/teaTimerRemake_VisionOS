//
//  TeaBrewingTimerViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation

class TeaBrewingTimerViewModel: TeaBrewingTimerFeature.viewModel {
    
    var totalDuration: TimeInterval
    
    init(brewingPhase: TeaBrewingPhase) {
        let state = TeaBrewingTimerFeature.State(duration: brewingPhase.phaseDuration, isTimerActive: true)
        self.totalDuration = brewingPhase.phaseDuration
        super.init(state: state)
    }
    
    override func handleViewAction(_ action: TeaBrewingTimerFeature.ViewAction) {
        switch action {
        case .didClickOnPlayButton:
            playTimer()
        case .didClickOnPauseButton:
            pauseTimer()
        case .didClickOnGoNextButton:
            onCallback(.goToNextStage)
        case .didClickOnGoBackButton:
            onCallback(.goToPreviousStage)
        }
    }
    
    
    func onReceiveTimer() {
        if state.remainingTime > 0 {
            state.remainingTime -= 1
        } else {
            pauseTimer()
        }
    }
    
    func didClickOnTimerControlButton() {
        if state.isTimerActive {
            handleViewAction(.didClickOnPauseButton)
        } else {
            handleViewAction(.didClickOnPlayButton)
        }
    }
    
    private func playTimer() {
        state.remainingTime = state.remainingTime == 0 ? totalDuration : state.remainingTime
        state.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        state.isTimerActive = true
    }
    
    private func pauseTimer() {
        state.timer.upstream.connect().cancel()
        state.isTimerActive = false
    }
}
