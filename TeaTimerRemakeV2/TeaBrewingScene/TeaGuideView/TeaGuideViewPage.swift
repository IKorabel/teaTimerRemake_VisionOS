//
//  TeaGuideView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 21.03.24.
//

import SwiftUI
import TipKit

struct TeaGuideViewPage: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var animate: Bool = false
    
    var body: some View {
        pageView
    }
    
    private var pageView: some View {
        VStack(spacing: 20) {
                Image(systemName: "leaf.fill")
                    .foregroundStyle(Color.ttGreen)
                    .font(.system(size: 100))
                Text("Next")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Nothing special. You should make a few things and don't core about everything will happen")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 400)
                    .foregroundStyle(.secondary)
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Title")
                })
                .tint(Color.ttGreen)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
            }
    }
}

#Preview {
    TeaGuideViewPage()
}
