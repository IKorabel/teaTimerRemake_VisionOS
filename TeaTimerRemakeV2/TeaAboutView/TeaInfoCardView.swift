//
//  TeaInfoCardView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 08.03.24.
//

import SwiftUI

struct TeaInfoCardView: View {
    var teaProperty: TeaProperty
    
    var body: some View {
        cardViewContent
        .frame(width: 120, height: 116)
        .background(.thinMaterial, in: .rect(cornerRadius: 20))
    }
    
    private var cardViewContent: some View {
        VStack(spacing: 10) {
            Image(systemName: teaProperty.iconName)
                .font(.system(size: 48))
                .foregroundStyle(Color.red)
                .symbolRenderingMode(.multicolor)
            Text(teaProperty.name)
                .bold()
                .font(.system(size: 14))
        }
        .frame(width: 120, height: 116)
        .background(.thinMaterial, in: .rect(cornerRadius: 20))
        
    }
}

#Preview {
    TeaInfoCardView(teaProperty: .init(name: "Pin", iconName: "mappin.circle.fill"))
}
