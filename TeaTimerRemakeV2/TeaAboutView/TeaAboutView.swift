//
//  TeaAboutView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 08.03.24.
//

import SwiftUI

struct TeaAboutView: View {
    
    let spacing: CGFloat = 10
    @State private var numberOfRows = 3
    
    var body: some View {
        
        let columns = Array(repeating: GridItem(.adaptive(minimum: 120), spacing: spacing), count: numberOfRows)
        
        ScrollView() {
            teaAboutHeader
                .padding(.top, 30)
            
            LazyVGrid(columns: columns, spacing: spacing, pinnedViews: [.sectionHeaders], content: {
                Section(header: categoryHeader(withHeader: "titl1")) {
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                }
                
                Section(header: categoryHeader(withHeader: "Something new")) {
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                    TeaInfoCardView()
                }
            })
            .padding(.horizontal)
        }
    }
    
    private var teaAboutHeader: some View {
        VStack(spacing: 10, content: {
            Image(systemName: "cup.and.saucer.fill")
                .foregroundStyle(.green)
                .font(.system(size: 60))
            Text("Shu Puerh")
                .font(.system(size: 24, weight: .bold))
            Button("Brew") {
                
            }
            .buttonStyle(TTButton(backgroundColor: .green))
        })
    }
    
    private var section: some View {
        Section {
            TeaInfoCardView()
            TeaInfoCardView()
                .hoverEffect()
            TeaInfoCardView()
        } header: {
            Text("How does it affect the condition?")
                .bold()
                .font(.title)
        }
    }
    
    private func categoryHeader(withHeader: String) -> some View {
        Text(withHeader)
            .font(.title2)
            .bold()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#Preview {
    TeaAboutView()
}
