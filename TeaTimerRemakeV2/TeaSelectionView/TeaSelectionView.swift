//
//  TeaSelectionView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI

struct TeaSelectionView: View {
    @StateObject var viewModel: TeaSelectionViewModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        TabView {
            ForEach(viewModel.teaList) { actualTeaPage in
                TeaSelectionCardView(tea: actualTeaPage) { action in
                    print("new page id: \(actualTeaPage.id)")
                    viewModel.handleViewAction(.didScrollTeaPage(newTeaPageId: actualTeaPage.id))
                    switch action {
                    case .readAboutTea:
                         viewModel.handleViewAction(.didClickOnInfoButton)
                    case .brewTea: print("brew tea")
                    case .addTeaToList: print("add to list")
                    }
                }
                .tabItem {
                    Label(
                        title: { Text(actualTeaPage.name) },
                        icon: {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(actualTeaPage.bgColor)
                        }
                    )
                }
                .tag(actualTeaPage.id)
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .sheet(isPresented: $viewModel.state.isTeaInfoSheetPresented, content: {
            TeaAboutView(teaInfo: viewModel.findSelectedTea()!.teaInformation)
        })
    }
}

#Preview {
    TeaSelectionView(viewModel: .init(state: .init()))
}
