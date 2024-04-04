//
//  TTAppViewModel.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 23.03.24.
//

import Foundation
import Observation
import SwiftUI

@Observable
class TTAppViewModel: TTAppFeature.viewModel {
    
    init() {
        super.init(state: .init(selectedTea: Tea.init(tea: .shuPuerh)))
    }
    
    func updateTeaInformationWindow(selectedTea: Tea) {
        if state.didOpenTeaInfoView {
           showSelectedTeaInformation(selectedTea: selectedTea)
        }
    }
    
    func openTeaInformationWindowInClick(selectedTea: Tea, openWindowAction: OpenWindowAction) {
        showSelectedTeaInformation(selectedTea: selectedTea)
        if !state.didOpenTeaInfoView {
            if isVisionOS {
                openWindowAction(id: WindowsConstants.teaInfoWindow)
                state.didOpenTeaInfoView = true
            } else {
                state.didPresentTeaInfoSheet = true
            }
        }
    }
    
    private func showSelectedTeaInformation(selectedTea: Tea) {
        self.state.selectedTea = selectedTea
    }
    
}
