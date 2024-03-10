//
//  TeaSelectionView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI

struct TeaSelectionView: View {
    var viewModel: TeaSelectionViewModel
    
    var body: some View {
        TabView {
            ForEach(viewModel.state.teaList) { actualTeaPage in
                TeaSelectionCardView(tea: actualTeaPage) { action in
                    print("action")
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    TeaSelectionView(viewModel: .init(state: .init()))
}
