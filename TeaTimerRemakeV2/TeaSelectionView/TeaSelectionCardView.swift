//
//  TeaSelectionCardView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import SwiftUI


struct TeaSelectionCardView: View {
    @Environment(TTAppViewModel.self) private var navViewModel
    
    @Environment(TeaSelectionViewModel.self) private var teaSelectionViewModel
    
    @Environment(\.openWindow) private var openWindow
    
    var tea: Tea
    
    var isVisionOs: Bool {
       #if os(visionOS)
           return true
        #else
           return false
        #endif
    }
    
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
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 70)
                .padding(.leading, 20)
        }
    }
    
    @ViewBuilder private func teaInteractionButtons() -> some View {
        if isVisionOs {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Button(action: {
                        print("add to your list")
                    }, label: {
                        Label("Add to your list", systemImage: "plus.circle.fill")
                            .foregroundStyle(Color.white)
                    })
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        navViewModel.openTeaInformationWindowInClick(selectedTea: tea, openWindowAction: openWindow)
                    }, label: {
                        Label("About", systemImage: "info.circle.fill")
                    })
                }
                
                Button(action: {
                    openWindow(id: WindowsConstants.brewingTimerWindow, value: tea.brewingWays)
                }, label: {
                    Label("Brew a tea", systemImage: "flame.fill")
                })

            }
        } else {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    TTStyleButton(title: "Add to your list", systemImage: "plus.circle.fill", backgroundColor: .blue) {
                      // add to list (iOS)
                    }
                    TTStyleButton(title: "About", systemImage: "info.circle.fill", backgroundColor: .purple) {
                        print("read about")
                        teaSelectionViewModel.handleViewAction(.didClickOnInfoButton)
                        // navViewModel.openTeaInformationWindowInClick(selectedTea: tea, openWindowAction: openWindow)
                    }
                }
                
                NavigationLink {
                    let teaPrebrewingSettingsViewModel = TeaPrebrewingSettingsViewModel(teaBrewingWays: tea.brewingWays)
                    TeaPrebrewingSettingsView(viewModel: teaPrebrewingSettingsViewModel)
                } label: {
                    Label("Brew a tea", systemImage: "info")
                }
                .buttonStyle(TTButton(backgroundColor: .ttGreen))
                
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
    TeaSelectionCardView(tea: .init(name: "tea", bgColor: .green, teaInformation: .init(teaName: "tea", teaImageName: "", teaProperties: [], teaBrewingPhases: []), brewingWays: []))
}
