//
//  TeaAboutView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 08.03.24.
//

import SwiftUI

struct TeaAboutView: View {
    
    var viewModel: TeaAboutViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(teaInfo: TeaInfo) {
        self.viewModel = TeaAboutViewModel(teaInfo: teaInfo)
    }
    var body: some View {
        
        let columns = Array(repeating: GridItem(.adaptive(minimum: 120), spacing: viewModel.spacing), count: viewModel.numberOfRows)
        
        NavigationStack {
            ScrollView {
                teaAboutHeader
                    .padding(.top, 30)
                
                LazyVGrid(columns: columns, spacing: viewModel.spacing, pinnedViews: [.sectionHeaders], content: {
                    
                    ForEach(viewModel.teaInfo.teaProperties) { teaPropertySection in
                        Section(header: categoryHeader(withHeader: teaPropertySection.sectionName)) {
                            ForEach(teaPropertySection.teaProperties) { teaProperty in
                                TeaInfoCardView(teaProperty: teaProperty)
                            }
                        }
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Your tea")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
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
            Text(viewModel.teaInfo.teaName)
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
    TeaAboutView(teaInfo: .init(teaName: "Shu", teaImageName: "cup.and.saucer.fill", teaProperties: [.init(section: .health, teaProperties: [.init(name: "pills", iconName: "pills.fill")])]))
}
