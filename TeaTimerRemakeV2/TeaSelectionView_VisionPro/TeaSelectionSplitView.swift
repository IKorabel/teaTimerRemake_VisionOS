//
//  TeaSelectionSplitView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 11.03.24.
//

import SwiftUI

struct TeaSelectionSplitView: View {
    @StateObject var viewModel: TeaSelectionVisionProViewModel
    
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
                    viewModel.handleViewAction(.didClickOnInfoButton)
                    print("read")
                case .brewTea:
                    print("brew")
                }
            }
            .ignoresSafeArea()
        }
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
