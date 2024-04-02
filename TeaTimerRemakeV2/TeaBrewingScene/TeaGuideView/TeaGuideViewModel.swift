//
//  TeaGuideViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 01.04.24.
//

import Foundation


class TeaGuideViewModel: TeaGuideViewModelFeature.viewModel {
    var guidePages: [TeaBrewingGuidePage]
    var envViewModel: TeaBrewingViewModel?
    
    init(guidePages: [TeaBrewingGuidePage]) {
        self.guidePages = guidePages
        super.init(state: .init())
    }
    
    func setupEnvironment(envViewModel: TeaBrewingViewModel) {
        self.envViewModel = envViewModel
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
        }
    }
    
    private func goNext() {
        state.selectedGuidePageTabIndex += 1
    }
}
