//
//  TeaBrewingSplitView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 17.03.24.
//

import SwiftUI

struct TeaBrewingSplitView: View {
    
    @StateObject private var teaBrewingViewModel = TeaBrewingViewModel()
    
    var body: some View {
           teaBrewingGuideWithTimerView()
    }
    
    @ViewBuilder private func teaBrewingGuideWithTimerView() -> some View {
        LazyVStack {
            TeaGuideView(viewModel: .init(guidePages: teaBrewingViewModel.selectedPhaseGuide))
                .frame(height: 299)
            TeaBrewingTimerView(viewModel: teaBrewingViewModel)
        }
    }
    
    @ViewBuilder private func teaBrewingPhaseCellView(brewingPhase: TeaBrewingPhase) -> some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Color.ttGreen)
            Text(brewingPhase.phaseName)
        }
    }
}

#Preview {
    TeaBrewingSplitView()
}
