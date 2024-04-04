//
//  TeaTimerRemakeV2App.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI
import SwiftData

@main
struct TeaTimerRemakeV2App: App {
    
    @StateObject private var appNavigationViewModel = TTAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            #if os(visionOS)
            TeaSelectionSplitView(viewModel: .init(state: .init()))
                .environment(appNavigationViewModel)
            #else
            TeaSelectionView(viewModel: .init(state: .init()))
                .environment(appNavigationViewModel)
            #endif
        }
        
        #if os(visionOS)
        ImmersiveSpace(id: "TeaImmersiveSpace") {
            TeaImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: WindowsConstants.immersiveTeaBrewingSpace) {
            ImmersiveTeaBrewingView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        WindowGroup(id: WindowsConstants.teaInfoWindow) {
            TeaAboutView(teaInfo: .init(teaName: "", teaImageName: "", teaProperties: [], teaBrewingPhases: []))
                .environment(appNavigationViewModel)
        }
        .defaultSize(width: 500, height: 800)
        #endif
        
        WindowGroup(id: WindowsConstants.brewingTimerWindow, for: [TeaBrewingWay].self) { $value in
            let viewModel = TeaPrebrewingSettingsViewModel(teaBrewingWays: value!)
            TeaPrebrewingSettingsView(viewModel: viewModel)
        }
        
    }
}
