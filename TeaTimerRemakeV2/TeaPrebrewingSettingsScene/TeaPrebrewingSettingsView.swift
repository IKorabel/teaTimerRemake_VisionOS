//
//  TeaPrebrewingSettingsView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 26.03.24.
//

import SwiftUI

struct TeaPrebrewingSettingsView: View {
    
    @StateObject var viewModel: TeaPrebrewingSettingsViewModel
    
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    LazyVGrid(columns: [.init(.adaptive(minimum: 300))], content: {
                        ForEach(viewModel.settingOptions) { settingsOption in
                            let isOptionSelected = viewModel.isOptionSelected(settingsOption: settingsOption)
                            PrebrewingSettingsGridView(teaSettingsOption: settingsOption, isSelected: isOptionSelected)
                                .environment(viewModel)
                        }
                    })
//                    Spacer()
//                    Button("Start brewing", action: {
//                       print("Should open windows")
//                    })
                }
                .padding(20)
                .navigationTitle("Brewing mode")
                .toolbar(content: {
                    ToolbarItem(placement: viewModel.isVisionOS ? .bottomBar : .bottomBar) {
                        Toggle(isOn: .constant(true), label: {
                            Text("Start Brewing")
                            
                        })
                        .toggleStyle(.button)
                    }
                })
                .contentMargins([.horizontal, .bottom], 10, for: .scrollContent)
            }
        }
    }
    
    private var gridView1: some View {
        ScrollView(.horizontal) {
            Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow {
//                    prebrewingSettingGridView
//                    prebrewingSettingGridView
//                    prebrewingSettingGridView
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
    
    private var list: some View {
        List {
            Section("Brewing mode") {
                prebrewingSettingListView
                prebrewingSettingListView
                prebrewingSettingListView
            }
        }
        .background(.clear)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
    }
    
    private var gridView: some View {
        LazyVGrid(columns: columns, spacing: 20, content: {
//            prebrewingSettingGridView
//            prebrewingSettingGridView
//            prebrewingSettingGridView
        })
        .padding()
    }
    
    private var prebrewingSettingListView: some View {
        HStack(spacing: 20) {
            Image("starSky")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(.rect(cornerRadius: 10))
            HStack() {
                Text("Option one")
                    .font(.title2)
                    .bold()
                Spacer()
            }
        }
        .listRowBackground(Color(uiColor: .secondarySystemBackground))
        .listRowSeparator(.hidden)
        .padding()
    }
}


#Preview {
    TeaPrebrewingSettingsView(viewModel: .init())
}


struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {

            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .font(.title)

                configuration.label
            }
        })
    }
}
