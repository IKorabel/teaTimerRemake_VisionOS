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
    
    var brewingPhases: [TeaBrewingPhase] = TeaBrewingPhase.mockBrewingPhases
    var totalDuration: TimeInterval
    
    var selectedPhase: TeaBrewingPhase {
        return brewingPhases.first(where: {$0.id == state.selectedPhaseId}) ?? TeaBrewingPhase.mockBrewingPhases.first!
    }
    
    var selectedPhaseGuide: [TeaBrewingGuidePage] {
        return selectedPhase.guidePages
    }
    
    var isGoNextButtonEnabled: Bool {
        return areButtonsDisabled(isNext: true)
    }
    
    var isGoBackButtonEnabled: Bool {
        return areButtonsDisabled(isNext: false)
    }
       
    init() {
        self.totalDuration = 0
        super.init(state: .init(selectedPhaseId: nil, duration: 0, isTimerActive: false, isGuideShowing: true, guidePages: []))
        let brewingPhase = brewingPhases.first!
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
        case .didClickOnNextGuidePageButton(let tabIndex, let dismissAction):
            didClickOnNextGuidePageButton(withTabIndex: tabIndex, dismissAction: dismissAction)
        case .didClickOnSkipManualButton:
            dismissGuidePage()
        }
    }
    
    private func guidePagesForSelectedBrewingPhase() -> [TeaBrewingGuidePage] {
        let selectedPhase = selectedPhase
        return selectedPhase.guidePages
    }
    
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
    
    private func didClickOnNextGuidePageButton(withTabIndex: Int, dismissAction: DismissAction) {
        let guidePages = selectedPhase.guidePages
        
        if withTabIndex + 1 == guidePages.count {
            dismissGuidePage()
            print("last last")
        } else {
          //  withTabIndex += 1
        }
    }
    
    func dismissGuidePage() {
        state.isGuideShowing = false
        didCompleteGuide()
    }
}
