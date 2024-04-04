//
//  TeaAboutView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 08.03.24.
//

import SwiftUI

struct TeaAboutView: View {
    
    @StateObject var viewModel: TeaAboutViewModel
    
    @Environment(TTAppViewModel.self) private var navViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dismissWindow) private var dismissWindow
    
    init(teaInfo: TeaInfo) {
        let teaAboutViewModel = TeaAboutViewModel(teaInfo: teaInfo)
        self._viewModel = StateObject(wrappedValue: teaAboutViewModel)
    }
    var body: some View {
        
        let columns = Array(repeating: GridItem(.adaptive(minimum: 120, maximum: 300), spacing: viewModel.spacing), count: viewModel.numberOfRows)
        
        NavigationStack {
            ScrollView {
                teaAboutHeader
                    .padding(.top, 30)
                
                LazyVGrid(columns: columns, spacing: viewModel.spacing, pinnedViews: [.sectionHeaders], content: {
                    
                    ForEach(navViewModel.state.selectedTea.teaInformation.teaProperties) { teaPropertySection in
                        Section(header: categoryHeader(withHeader: teaPropertySection.sectionName)) {
                            ForEach(teaPropertySection.teaProperties) { teaProperty in
                                TeaInfoCardView(teaProperty: teaProperty)
                            }
                        }
                    }
                })
                .padding(.horizontal)
            }
            .onAppear(perform: {
                print("navViewModel: \(navViewModel.state.selectedTea)")
            })
            .navigationTitle("Your tea")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.dismiss(dismissAction: dismiss, dismissWindowAction: dismissWindow)
                        navViewModel.state.didOpenTeaInfoView = false
                    } label: {
                        Image(systemName: viewModel.isVisionOS ? "xmark" : "xmark.circle.fill")
//                            .foregroundStyle(Color.ttGreen)
                    }
                }
            }
            
            
        }
    }
    
    private var teaAboutHeader: some View {
        VStack(spacing: 20, content: {
            Image(systemName: "cup.and.saucer.fill")
           //     .foregroundStyle(Color.ttGreen)
                .font(.system(size: 60))
            Text(navViewModel.state.selectedTea.name)
                .font(.system(size: 24, weight: .bold))
            Button(action: {
                
            }, label: {
                Text("Brew")
                    .frame(maxWidth: 123, maxHeight: 10)
            })
            .buttonStyle(TTButton(backgroundColor: viewModel.isVisionOS ? .clear : .ttGreen))
            //.buttonStyle(TTButton(backgroundColor: .ttGreen))
        })
    }
    
    private func categoryHeader(withHeader: String?) -> some View {
        Text(withHeader ?? "")
            .font(.title2)
            .bold()
            .padding(.top, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#Preview {
    TeaAboutView(teaInfo: .init(teaName: "Shu", teaImageName: "cup.and.saucer.fill", teaProperties: [.init(section: .health, teaProperties: [.init(name: "pills", iconName: "pills.fill")])], teaBrewingPhases: []))
}
