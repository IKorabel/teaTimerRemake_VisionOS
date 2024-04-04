//
//  State.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 23.03.24.
//

import Foundation

extension TTAppFeature {
    
    struct State {
        var selectedTea: Tea = .init(tea: .shuPuerh)
        var didOpenTeaInfoView: Bool = false
        var didPresentTeaInfoSheet: Bool = false
    }
}
