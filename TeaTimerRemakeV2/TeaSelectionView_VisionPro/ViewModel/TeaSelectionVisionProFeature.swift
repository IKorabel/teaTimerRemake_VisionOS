//
//  TeaSelectionVisionProFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 11.03.24.
//

import Foundation

struct TeaSelectionViewVisionProFeature {
    typealias viewModelType = ViewModel<State, ViewAction, CallbackAction>
    
    struct State {
        var selectedIndex: Tea.ID?
        var isTeaInfoSheetPresented = false
    }
    
    enum ViewAction {
        case didSelectTeaInList
    }
    
    enum CallbackAction {
        case showSelectedTeaScreen
    }
}
