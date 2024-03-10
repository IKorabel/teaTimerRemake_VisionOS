//
//  TeaInfoCardView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 08.03.24.
//

import SwiftUI

struct TeaInfoCardView: View {
    var body: some View {
        ZStack {
            Color.init(uiColor: .tertiarySystemGroupedBackground).ignoresSafeArea()
            cardViewContent
        }
        .frame(width: 120, height: 116)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    private var cardViewContent: some View {
        VStack(spacing: 10) {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 48))
                .foregroundStyle(Color.red)
            Text("Pin")
                .bold()
                .font(.system(size: 20))
        }
    }
}

#Preview {
    TeaInfoCardView()
}
