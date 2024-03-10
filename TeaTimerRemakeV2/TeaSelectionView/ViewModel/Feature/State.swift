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
        var teaList: [TeaSelectionViewFeature.Tea] = [.init(name: "Shu Puerh", bgColor: .black), .init(name: "Sheng Puerh", bgColor: .green), .init(name: "Red", bgColor: .red)]
    }
}
