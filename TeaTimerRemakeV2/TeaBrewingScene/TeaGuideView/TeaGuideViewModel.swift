//
//  TeaGuideViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 01.04.24.
//

import Foundation


class TeaGuideViewModel: TeaGuideViewModelFeature.viewModel {
    var guidePages: [TeaBrewingGuidePage]
    
    init(guidePages: [TeaBrewingGuidePage]) {
        self.guidePages = guidePages
        super.init(state: .init())
    }
    
//
//    init(guidePages: [TeaBrewingGuidePage]) {
//        self.guidePages = guidePages
//        super.init(state: .init())
//    }
    
    var isLastPage: Bool {
        print("GuidePAgesCount: \(guidePages.count)")
        return state.selectedGuidePageTabIndex + 1 == guidePages.count
    }
    
    override func handleViewAction(_ action: TeaGuideViewModelFeature.ViewAction) {
        switch action {
        case .didClickOnDoneButton:
            goNext()
        case .didChangeBrewingPhase(let envViewModel):
            updateGuideView(viewModel: envViewModel)
        }
    }
    
    private func goNext() {
        state.selectedGuidePageTabIndex += 1
    }
    
    private func updateGuideView(viewModel: TeaBrewingViewModel) {
        self.guidePages = viewModel.selectedPhaseGuide
        self.state.selectedGuidePageTabIndex = 0
    }
}
