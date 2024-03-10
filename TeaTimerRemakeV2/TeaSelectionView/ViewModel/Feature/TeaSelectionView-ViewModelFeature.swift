//
//  TeaSelectionView-ViewModelFeature.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation
import SwiftUI

struct TeaSelectionViewFeature {
    typealias ViewModelType = ViewModel<State, ViewAction, CallbackAction>
    
    struct Tea: Identifiable {
        var id = UUID()
        var name: String
        var bgColor: Color
    }
    
}

