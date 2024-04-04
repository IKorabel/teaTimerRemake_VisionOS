//
//  TeaBrewingState.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import Foundation
import SwiftUI

extension TeaBrewingFeature {
    
    struct State {
        var selectedPhaseId: TeaBrewingPhase.ID?
        var selectedGuidePageIndex: Binding<Int> = .constant(0)
        
        var selectedTab: Int = 0
        var remainingTime: TimeInterval
        var isTimerActive: Bool
        var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        //Presentation
        var isGuideShowing: Bool = true
        var guidePageForSelectedBrewingPhase: [TeaBrewingGuidePage]
    
        var isGuideSheetPresented: Bool = true
        
        init(selectedPhaseId: TeaBrewingPhase.ID?, duration: TimeInterval, isTimerActive: Bool, isGuideShowing: Bool, guidePages: [TeaBrewingGuidePage]) {
            self.remainingTime = duration
            self.isTimerActive = isTimerActive
            self.selectedPhaseId = selectedPhaseId
            self.isGuideShowing = isGuideShowing
            self.guidePageForSelectedBrewingPhase = guidePages
        }
        
        init(selectedPhase: TeaBrewingPhase) {
            let isGuideShowing = selectedPhase.isGuideCompleted ? false : true
            self.init(selectedPhaseId: selectedPhase.id, duration: selectedPhase.phaseDuration, isTimerActive: false, isGuideShowing: isGuideShowing, guidePages: selectedPhase.guidePages)
        }
        
    }
    
    
}
