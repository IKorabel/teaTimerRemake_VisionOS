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
            buildContentView()
        }
    }
    
    @ViewBuilder
    private func buildContentView() -> some View {
        if viewModel.isVisionOS {
            contentViewVisionOS
        } else {
            contentViewiOS
        }
    }
    
    private var contentViewiOS: some View {
        ZStack {
            teaWaveView
                .ignoresSafeArea(edges: .bottom)
            VStack {
                Spacer()
                arrowsView
            }
        }
        .toolbar(.hidden, for: .bottomBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.state.isGuideSheetPresented = true
                }, label: {
                    Image(systemName: "book.fill")
                })
                .foregroundStyle(Color.ttGreen)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .controlSize(.large)
            }
        })
            .sheet(isPresented: $viewModel.state.isGuideSheetPresented, content: {
            TeaGuideView(viewModel: .init(guidePages: viewModel.selectedPhaseGuide))
                .environment(viewModel)
        })
    }
    
    private var contentViewVisionOS: some View {
            ZStack {
                teaWaveView
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
                
                TeaGuideView(viewModel: .init(guidePages: viewModel.selectedPhaseGuide))
                    .environment(viewModel)
                    .opacity(viewModel.state.isGuideShowing ? 1.0 : 0)
                    .animation(.spring, value: viewModel.state.isGuideShowing)
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
    
    
    private var placementForToolbar: ToolbarItemPlacement {
        #if os(visionOS)
        return .bottomOrnament
        #else
        return .bottomBar
        #endif
    }
    
    private var timerView: some View {
        VStack(spacing: 50) {
            progressRingView
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
    
    private var teaWaveView: some View {
        TeaWaveView(totalDuration: viewModel.totalDuration,
                    timeRemaining: viewModel.state.remainingTime)
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
        .padding(.horizontal, 30)
        .padding(.bottom, 50)
    }
    
    private var arrowsView: some View {
        HStack(content: {
            Button(action: { viewModel.handleViewAction(.didClickOnGoBackButton) }, label: {
                Image(systemName: "chevron.backward")
            })
            .makeCircularButton(isVisionOS: viewModel.isVisionOS)
            .disabled(viewModel.isGoBackButtonEnabled)
            Spacer()
            
            Button(action: { viewModel.didClickOnTimerControlButton()}, label: {
                Image(systemName: viewModel.state.isTimerActive ? "pause.fill" : "play.fill")
            })
            .makeCircularButton(isVisionOS: viewModel.isVisionOS)
            .disabled(viewModel.isPlayStopButtonEnabled)
            
            Spacer()
            
            Button(action: { viewModel.handleViewAction(.didClickOnGoNextButton)}, label: {
                Image(systemName: "chevron.right")
            })
            .makeCircularButton(isVisionOS: viewModel.isVisionOS)
            .disabled(viewModel.isGoNextButtonEnabled)
        })
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder private func actualPageView(brewingPhase: TeaBrewingPhase, index: Int) -> some View {
        Label(
            title: { Text(brewingPhase.phaseName) },
            icon: { Image(systemName: "\(index + 1).circle") }
        )
    }
}

#Preview {
    TeaBrewingTimerView(viewModel: .init(brewingPhases: [.init(phaseName: "Name", phaseDescription: "", phaseDuration: 10, shouldShowTick: true, guidePages: [.mockPage, .mockPage]), .init(phaseName: "Name1", phaseDescription: "", phaseDuration: 10, shouldShowTick: true, guidePages: [.mockPage, .mockPage])]))
}
