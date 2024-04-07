//
//  Water.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.04.24.
//

import Foundation
import SwiftUI

struct TeaWaveView: View {
    let totalDuration: TimeInterval
    var timeRemaining: TimeInterval
    
    @State var waveOffset: Angle = .degrees(0)
    @State var percent: Double = 0
    
    private var remainingTimerTextFont: Font {
        #if os(visionOS)
        return .extraLargeTitle
        #else
        return .largeTitle.bold()
        #endif
    }
    
    private var informationTextFont: Font {
        #if os(visionOS)
        return .extraLargeTitle2
        #else
        return .title.bold()
        #endif
    }
    
    private var textForegroundStyle: Color {
        #if os(visionOS)
        return Color(.white)
        #else
        return Color(percent >= 60 ? Color.white : Color.black)
        #endif
    }
    
    
    var body: some View {
        ZStack {
            TeaWave(offSet: waveOffset, percent: percent)
                .fill(Color.ttGreen)
            VStack(spacing: 20) {
                Image(systemName: percent > 0 && percent < 100 ? "clock" : "mug.fill")
                    .contentTransition(.symbolEffect)
                    .font(informationTextFont)
                    .imageScale(.large)
                Text(percent > 0 && percent < 100 ? "Your tea will be ready in" : "Your tea is ready, you can pour it")
                    .multilineTextAlignment(.center)
                    .contentTransition(.interpolate)
                    .font(informationTextFont)
                Text(formattedTime())
                    .font(remainingTimerTextFont)
                    .opacity(percent == 1 ? 0 : 1)
            }
            .foregroundStyle(textForegroundStyle)
            .padding(.horizontal)
        }
            .onChange(of: timeRemaining) {
                countPercent()
            }
            .onAppear(perform: {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.waveOffset = Angle(degrees: 360)
                }
            })
    }
    
    private func countPercent() {
        let percent = 1.0 - (timeRemaining / totalDuration)
        self.percent = max(0, min(100, percent * 100))
        print("Percent: \(percent)")
    }
    
    private func formattedTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02D:%02D", minutes, seconds)
    }
}

struct TeaWave: Shape {
    
    var offSet: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offSet.degrees }
        set { offSet = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowestWave = 0.02
        let highestWave = 1.00
        
        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        let waveHeight = 0.015 * rect.height
        let yOffSet = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffSet + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yOffSet + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

#Preview {
    TeaWaveView(totalDuration: 10, timeRemaining: 10, percent: 50)
}
