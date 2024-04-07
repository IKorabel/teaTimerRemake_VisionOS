//
//  TeaBrewingViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation
import SwiftUI

@Observable
class TeaBrewingViewModel: TeaBrewingFeature.viewModel {
    
    var brewingPhases: [TeaBrewingPhase]
    var totalDuration: TimeInterval
    
    var selectedPhase: TeaBrewingPhase {
        return brewingPhases.first(where: {$0.id == state.selectedPhaseId}) ?? TeaBrewingPhase.mockBrewingPhases.first!
    }
    
    var selectedPhaseGuide: [TeaBrewingGuidePage] {
        return selectedPhase.guidePages
    }
    
    var isPlayStopButtonEnabled: Bool {
        return !state.isGuideShowing && !state.isGuideSheetPresented
    }
    
    var isGoNextButtonEnabled: Bool {
        return areButtonsDisabled(isNext: true)
    }
    
    var isGoBackButtonEnabled: Bool {
        return areButtonsDisabled(isNext: false)
    }
       
    init(brewingPhases: [TeaBrewingPhase]) {
        self.totalDuration = 0
        self.brewingPhases = brewingPhases
        super.init(state: .init(selectedPhaseId: nil, duration: 0, isTimerActive: false, isGuideShowing: true, guidePages: []))
        let brewingPhase = brewingPhases.first ?? .init(phaseName: "Empty", phaseDescription: "", phaseDuration: 0, shouldShowTick: false, guidePages: [])
        self.totalDuration = brewingPhase.phaseDuration
        let state = TeaBrewingFeature.State(selectedPhase: brewingPhase)
        self.state = state
    }
    
    
    override func handleViewAction(_ action: TeaBrewingFeature.ViewAction) {
        switch action {
        case .didClickOnPlayButton:
            playTimer()
        case .didClickOnPauseButton:
            pauseTimer()
        case .didClickOnGoNextButton:
            goToNextStage()
        case .didClickOnGoBackButton:
            goToPreviousPage()
        case .didClickOnSkipManualButton:
            dismissGuidePage()
        }
    }
    
    private func guidePagesForSelectedBrewingPhase() -> [TeaBrewingGuidePage] {
        let selectedPhase = selectedPhase
        return selectedPhase.guidePages
    }
    
//    private func countPercent() {
//        let percent = 1.0 - (timeRemaining / totalDuration)
//        self.percent = max(0, min(100, percent * 100))
//    }
    
    func selectedBrewingPhase() -> TeaBrewingPhase? {
        let selectedBrewingPhase = brewingPhases.first(where: {$0.id == state.selectedPhaseId})
        return selectedBrewingPhase
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
    
    private func areButtonsDisabled(isNext: Bool) -> Bool {
        guard let phaseIndexForStage = brewingPhases.firstIndex(where: { $0.id == state.selectedPhaseId }) else {
            return true // Disable buttons if phase is not found
        }
        
        let nextIndex = isNext ? brewingPhases.index(after: phaseIndexForStage) : brewingPhases.index(before: phaseIndexForStage)
        
        if isNext {
            return nextIndex >= brewingPhases.endIndex // Disable if next index exceeds bounds
        } else {
            return nextIndex < 0 // Disable if previous index is negative
        }
    }

    
    private func goToNextStage() {
        goToStage(isNext: true)
    }
    
    private func goToPreviousPage() {
        goToStage(isNext: false)
    }
    
    private func goToStage(isNext: Bool) {
        guard let phaseIndexForStage = brewingPhases.firstIndex(where: { $0.id == state.selectedPhaseId }) else { return }
        let nextIndex = isNext ? brewingPhases.index(after: phaseIndexForStage) : brewingPhases.index(before: phaseIndexForStage)
        guard nextIndex < brewingPhases.endIndex && nextIndex >= 0 else { return }
        let nextPhase = brewingPhases[nextIndex]
        state.timer.upstream.connect().cancel()
        state.selectedPhaseId = nextPhase.id
        state.selectedTab = nextIndex
        state.isGuideShowing = !selectedPhase.isGuideCompleted
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
    
    //MARK: Guide Page View
    
    func didCompleteGuide() {
        guard let completedGuideInBrewingPhaseIndex = brewingPhases.firstIndex(where: { $0.id == selectedPhase.id}) else { return }
        brewingPhases[completedGuideInBrewingPhaseIndex].isGuideCompleted = true
    }
    
    func dismissGuidePage() {
        if isVisionOS {
            state.isGuideShowing = false
        } else {
            state.isGuideSheetPresented = false
        }
        didCompleteGuide()
    }
    
    //MARK: OS optimization
    
}
