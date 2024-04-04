//
//  TeaPrebrewingSettingsView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 26.03.24.
//

import SwiftUI

struct TeaPrebrewingSettingsView: View {
    
    @StateObject var viewModel: TeaPrebrewingSettingsViewModel
    
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    init(viewModel: TeaPrebrewingSettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    prebrewingSettingsGrid
                }
                .padding(.top, 50)
                .padding(20)
                .navigationTitle("Brewing mode")
                .toolbar(content: {
                    ToolbarItem(placement: .bottomBar) {
                        startBrewingToggleButton
                    }
                })
                .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
            }
        }
    }
    
    private var prebrewingSettingsGrid: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 250))], content: {
            ForEach(viewModel.teaBrewingWays) { settingsOption in
                let isOptionSelected = viewModel.isOptionSelected(settingsOption: settingsOption)
                PrebrewingSettingsGridView(teaSettingsOption: settingsOption, isSelected: isOptionSelected)
                    .environment(viewModel)
            }
        })
    }
    
    private var startBrewingToggleButton: some View {
        NavigationLink {
            TeaBrewingTimerView(viewModel: .init(brewingPhases: viewModel.getSelectedOption()))
        } label: {
            Text("Start brewing")
        }
        .buttonStyle(.bordered)

    }
    
}


#Preview {
    TeaPrebrewingSettingsView(viewModel: .init(teaBrewingWays: []))
}

