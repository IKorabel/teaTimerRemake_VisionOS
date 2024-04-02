//
//  TeaGuideView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 21.03.24.
//

import SwiftUI

struct TeaGuideView: View {
    @Environment(TeaBrewingViewModel.self) private var envViewModel
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: TeaGuideViewModel
    
    init(viewModel: TeaGuideViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.state.selectedGuidePageTabIndex) {
                ForEach(Array(envViewModel.selectedPhaseGuide.enumerated()), id: \.offset) { index, guidePage in
                    buildTeaGuideViewPage(guidePage: guidePage)
                        .tag(index)
                }
            }
        }
        .onChange(of: envViewModel.state.selectedPhaseId, { oldValue, newValue in
            print("should change")
            viewModel.state.selectedGuidePageTabIndex = 0
        })
          .padding(.bottom, 20)
          .tabViewStyle(.page(indexDisplayMode: .always))
          .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
     
    
    @ViewBuilder
    private func buildTeaGuideViewPage(guidePage: TeaBrewingGuidePage) -> some View {
        VStack(spacing: 20) {
            Image(systemName: guidePage.symbol)
                .foregroundStyle(Color.ttGreen)
                .font(.system(size: 100))
            Text(guidePage.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text(guidePage.description)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            teaGuideViewPageButtons()
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
    
    private func teaGuideViewPageButtons() -> some View {
        VStack {
            Button("Done", action: {
                print("Count: \(envViewModel.selectedPhase.guidePages.count)")
                print("Index: \(viewModel.state.selectedGuidePageTabIndex + 1)")
                if viewModel.state.selectedGuidePageTabIndex + 1 == envViewModel.selectedPhase.guidePages.count {
                    envViewModel.dismissGuidePage()
                } else {
                    viewModel.handleViewAction(.didClickOnDoneButton)
                }
            })
            .tint(Color.ttGreen)
        }
    }
}

#Preview {
    TeaBrewingTimerView(viewModel: .init())
}

