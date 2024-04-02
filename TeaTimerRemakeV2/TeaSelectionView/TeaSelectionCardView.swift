//
//  TeaSelectionCardView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI

struct TeaSelectionCardView: View {
    @Environment(TTAppViewModel.self) private var navViewModel
    
    var tea: Tea
    
    var isVisionOs: Bool {
       #if os(visionOS)
           return true
        #else
           return false
        #endif
    }
    var teaSelectionCardViewAction: (TeaSelectionViewFeature.CallbackAction) -> Void
    
    var body: some View {
        teaInfo()
    }
    
    
    @ViewBuilder private func teaInfo() -> some View {
        NavigationStack {
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
        .toolbar(.hidden)
    }
    
    @ViewBuilder private func teaInteractionButtons() -> some View {
        if isVisionOs {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Button(action: { teaSelectionCardViewAction(.addTeaToList)}, label: {
                        Label("Add to your list", systemImage: "plus.circle.fill")
                            .foregroundStyle(Color.white)
                    })
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                    
                    Button(action: { teaSelectionCardViewAction(.readAboutTea)}, label: {
                        Label("About", systemImage: "info.circle.fill")
                    })
                }
                NavigationLink(value: "") {
                    Label("Brew a tea", systemImage: "flame.fill")
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    TTStyleButton(title: "Add to your list", systemImage: "plus.circle.fill", backgroundColor: .blue) {
                        teaSelectionCardViewAction(.addTeaToList)
                    }
                    TTStyleButton(title: "About", systemImage: "info.circle.fill", backgroundColor: .purple) {
                        teaSelectionCardViewAction(.readAboutTea)
                    }
                }
                TTStyleButton(title: "Brew a tea", systemImage: "info", backgroundColor: .ttGreen) {
                    teaSelectionCardViewAction(.brewTea)
                }
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
    TeaSelectionCardView(tea: .init(name: "tea", bgColor: .green, teaInformation: .init(teaName: "tea", teaImageName: "", teaProperties: [], teaBrewingPhases: []))) { action in
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
