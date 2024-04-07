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
    
    #if os(visionOS)
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    #endif
    
    
    init(viewModel: TeaSelectionVisionProViewModel) {
        let viewModel = viewModel
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationSplitView {
            List(viewModel.allTeas, selection: $viewModel.state.selectedIndex) { tea in
                    listCell(tea: tea)
            }
            .navigationTitle("Select Tea")
        } detail: {
            let selectedTea = viewModel.defineSelectedTea()
            TeaSelectionCardView(tea: selectedTea)
                .environment(navViewModel)
                .ignoresSafeArea()
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
                .environment(navViewModel)
        })
        
    }
    
    private func listCell(tea: Tea) -> some View {
        Label(title: { Text(tea.name) }, icon: { Image(systemName: "leaf.fill").foregroundStyle(tea.bgColor) })
    }

}

#Preview {
    TeaSelectionSplitView(viewModel: .init(state: .init()))
}
