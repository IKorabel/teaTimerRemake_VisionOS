//
//  State.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation

//MARK: State
extension TeaSelectionViewFeature {
    
    struct State {
        var isTeaInfoSheetPresented = false
        var selectedIndex: Tea.ID?
    }
}
