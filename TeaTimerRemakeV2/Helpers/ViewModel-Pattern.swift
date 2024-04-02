//
//  ViewModelPattern.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation

class ViewModel<State, ViewAction, CallbackAction>: ObservableObject, Identifiable {
    @Published var state: State
    
    var isVisionOS: Bool {
        #if os(visionOS)
        return true
        #else
        return false
        #endif
    }

    var onCallback: (CallbackAction) -> Void = { _ in }

    init(state: State) {
        self.state = state
    }

    func handleViewAction(_ action: ViewAction) {
        assertionFailure("Received unhandled action: \(action)")
    }
}
