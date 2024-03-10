//
//  TeaSelectionCardView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI

struct TeaSelectionCardView: View {
    var tea: TeaSelectionViewFeature.Tea
    
    var teaSelectionCardViewAction: (TeaSelectionViewFeature.CallbackAction) -> Void
    
    var body: some View {
        teaInfo()
    }
    
    
    @ViewBuilder private func teaInfo() -> some View {
        ZStack {
            VideoPlayerView(url: "puerhTeaVideo")
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                Text(tea.name)
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                teaInteractionButtons()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 70)
            .padding(.leading, 20)
        }
    }
    
    @ViewBuilder private func teaInteractionButtons() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                TTStyleButton(title: "Add to your list", systemImage: "plus.circle.fill", backgroundColor: .blue) {
                    teaSelectionCardViewAction(.addTeaToList)
                }
                TTStyleButton(title: "About", systemImage: "info.circle.fill", backgroundColor: .purple) {
                    teaSelectionCardViewAction(.readAboutTea)
                }
            }
            TTStyleButton(title: "Brew a tea", systemImage: "info", backgroundColor: .green) {
                teaSelectionCardViewAction(.brewTea)
            }
        }
    }
    
    @ViewBuilder private func TTStyleButton(title: String, systemImage: String, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button(title, systemImage: systemImage) {
            action()
        }
        .buttonStyle(TTButton(backgroundColor: backgroundColor))
    }
}

#Preview {
    TeaSelectionCardView(tea: .init(name: "tea", bgColor: .green)) { action in
        switch action {
        case .addTeaToList:
            print("add")
        case .readAboutTea:
            print("read")
        case .brewTea:
            print("brew")
        }
    }
}
