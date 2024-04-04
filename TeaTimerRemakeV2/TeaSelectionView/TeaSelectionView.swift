//
//  TeaSelectionView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI

struct TeaSelectionView: View {
    
    @Environment(TTAppViewModel.self) private var navViewModel
    @StateObject private var viewModel: TeaSelectionViewModel
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    init(viewModel: TeaSelectionViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(viewModel.teaList) { actualTeaPage in
                    TeaSelectionCardView(tea: actualTeaPage)
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
                        .environment(viewModel)
                        .ignoresSafeArea()
                }
            }
            .toolbar(.hidden)
            .toolbarBackground(Color.black)
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
