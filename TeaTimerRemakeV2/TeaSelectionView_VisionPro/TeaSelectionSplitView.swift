//
//  TeaSelectionSplitView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 11.03.24.
//

import SwiftUI

struct TeaSelectionSplitView: View {
    @StateObject var viewModel: TeaSelectionVisionProViewModel
    @Environment(TTAppViewModel.self) private var navViewModel
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    
    @State private var navigateToBrewingTimer: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.allTeas, selection: $viewModel.state.selectedIndex) { tea in
                    Label(title: { Text(tea.name) },
                          icon: {
                        Image(systemName: "leaf.fill").foregroundStyle(tea.bgColor) })
            }
            .navigationTitle("Select Tea")
        } detail: {
            let selectedTea = viewModel.defineSelectedTea()
            TeaSelectionCardView(tea: selectedTea) { action in
                switch action {
                case .addTeaToList:
                    print("add tea to list")
                case .readAboutTea:
                    navViewModel.openTeaInformationWindowInClick(selectedTea: selectedTea, openWindowAction: openWindow)
                case .brewTea:
//                    dismissWindow(id: WindowsConstants.teaInfoWindow)
//                    openWindow(id: WindowsConstants.brewingTimerWindow)
//                    openWindow(id: WindowsConstants.brewingGuideWindow)
                    print("brew")
                }
            }
            .environment(navViewModel)
            .ignoresSafeArea()
            .navigationDestination(for: String.self) { value in
                TeaPrebrewingSettingsView(viewModel: .init())
            }
        }
        .onChange(of: viewModel.state.selectedIndex, { oldValue, newValue in
            let selectedTea = viewModel.defineSelectedTea()
            navViewModel.updateTeaInformationWindow(selectedTea: selectedTea)
        })
        .sheet(isPresented: $viewModel.state.isTeaInfoSheetPresented,
               onDismiss: { 
            viewModel.state.isTeaInfoSheetPresented = false
        }, content: {
            TeaAboutView(teaInfo: viewModel.defineSelectedTea().teaInformation)
        })
        
    }

}

#Preview {
    TeaSelectionSplitView(viewModel: .init(state: .init()))
}
