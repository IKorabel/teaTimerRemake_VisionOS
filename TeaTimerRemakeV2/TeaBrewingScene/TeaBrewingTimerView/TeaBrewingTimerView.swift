//
//  TeaBrewingTimerView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 12.03.24.
//

import SwiftUI

struct TeaBrewingTimerView: View {
    
    @StateObject var viewModel: TeaBrewingViewModel
    
    #if os(visionOS)
    @Environment(\.openImmersiveSpace) private var openImmersiveScene
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var isShowingImmersiveSpace = false
    #endif
    
    var body: some View {
        NavigationStack {
            ZStack {
                TeaGuideView(viewModel: .init(guidePages: viewModel.selectedPhaseGuide))
                    .environment(viewModel)
                    .opacity(viewModel.state.isGuideShowing || viewModel.state.isGuideSheetPresented ? 1.0 : 0)
                    .animation(.spring, value: viewModel.state.isGuideShowing)
                    .ignoresSafeArea()
                timerView
                    .toolbar {
                        ToolbarItem(placement: placementForToolbar) {
                            VStack {
                                Text(viewModel.selectedPhase.phaseName)
                                    .font(.title)
                                arrowsView
                            }
                            .padding()
                        }
                    }
                    .modifier(BlurRadiusModifier(blurRadius: viewModel.state.isGuideShowing ? 20 : 0))
                    .blur(radius: viewModel.state.isGuideShowing ? 20 : 0)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle(isOn: $viewModel.state.isGuideShowing, label: {
                        Image(systemName: viewModel.state.isGuideShowing ? "multiply" : "book")
                            .contentTransition(.symbolEffect)
                            .imageScale(.large)
                    })
                    .toggleStyle(.button)
                }
            }
        }
        #if os(iOS)
        .sheet(isPresented: $viewModel.state.isGuideSheetPresented, content: {
            TeaGuideView(viewModel: .init(guidePages: viewModel.selectedPhaseGuide))
                .environment(viewModel)
        })
        #endif
        .onChange(of: viewModel.state.isGuideShowing) { _, _ in
        }
    }
    
    private var contentViewiOS: some View {
        NavigationStack {
            timerView
                .toolbar {
                    ToolbarItem(placement: placementForToolbar) {
                        VStack {
                            Text(viewModel.selectedPhase.phaseName)
                                .font(.title)
                            arrowsView
                        }
                        .padding()
                    }
                }
        }
    }
    
    private var placementForToolbar: ToolbarItemPlacement {
        #if os(visionOS)
        return ToolbarItemPlacement.bottomOrnament
        #else
        return ToolbarItemPlacement.bottomBar
        #endif
    }
    
    private var timerView: some View {
        VStack(spacing: 50) {
            Label(
                title: { Text(viewModel.selectedPhase.phaseDescription) },
                icon: { Image(systemName: "42.circle") }
            )
            .font(.largeTitle)
            progressRingView
            Spacer()
        }
        .padding(.vertical)
        .navigationTitle(viewModel.selectedPhase.phaseName)
        .onReceive(viewModel.state.timer, perform: { time in
            viewModel.onReceiveTimer()
        })
        .onAppear(perform: {
            viewModel.handleViewAction(.didClickOnPauseButton)
        })
    }
    
    private var progressRingView: some View {
        CircularProgressView(timeRemaining: viewModel.state.remainingTime,
                             totalDuration: viewModel.totalDuration)
    }
    
    private var arrowsView: some View {
        HStack(spacing: 20, content: {
            Button(action: { viewModel.handleViewAction(.didClickOnGoBackButton) }, label: {
                Image(systemName: "chevron.backward")
            })
            .disabled(viewModel.isGoBackButtonEnabled)
            
            Button(action: { viewModel.didClickOnTimerControlButton()}, label: {
                Image(systemName: viewModel.state.isTimerActive ? "pause.fill" : "play.fill")
            })
            .disabled(viewModel.state.isGuideShowing)
            
            Button(action: { viewModel.handleViewAction(.didClickOnGoNextButton)}, label: {
                Image(systemName: "chevron.right")
            })
            .disabled(viewModel.isGoNextButtonEnabled)
            
            #if os(visionOS)
            .onChange(of: isShowingImmersiveSpace) { _, isShowing in
                Task {
                    if isShowing {
                        await dismissImmersiveSpace()
                    } else {
                        await openImmersiveScene(id: "TeaImmersiveSpace")
                    }
                }
            }
            #endif
        })
        .padding()
    }
    
    @ViewBuilder private func actualPageView(brewingPhase: TeaBrewingPhase, index: Int) -> some View {
        Label(
            title: { Text(brewingPhase.phaseName) },
            icon: { Image(systemName: "\(index + 1).circle") }
        )
    }
}

#Preview {
    TeaBrewingTimerView(viewModel: .init(brewingPhases: []))
}
