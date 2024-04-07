//
//  CircularProgressView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 12.03.24.
//

import Foundation
import SwiftUI

struct CircularProgressView: View {
    let totalDuration: TimeInterval
    var timeRemaining: TimeInterval
    
    @State var waveOffset: Angle = .degrees(0)
    @State var percent: Double = 0
    
    
    init(timeRemaining: TimeInterval, totalDuration: TimeInterval) {
        self.totalDuration = totalDuration
        self.timeRemaining = timeRemaining
    }
    
    var body: some View {
        let formattedRemainingTime = CGFloat(1 - (timeRemaining / totalDuration))
        
            ZStack {
                TeaWave(offSet: waveOffset, percent: percent)
                                      .fill(Color.ttGreen)
                                      .ignoresSafeArea()
                                      .onAppear(perform: {
                                          withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                                         self.waveOffset = Angle(degrees: 360)
                                          }
                                      })
                // Background for the progress bar
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.1)
                    .foregroundColor(Color.ttGreen)
                // Foreground or the actual progress bar
                Circle()
                    .trim(from: 0.0, to: CGFloat(1 - (timeRemaining / totalDuration)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.ttGreen)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: timeRemaining)
//                    .overlay(
////                        Wave(offSet: waveOffset, percent: formattedRemainingTime * 100)
////                                        .fill(Color.ttGreen)
//                    )
                Text("\(formattedTime())")
                    .font(.title)
                    .onChange(of: timeRemaining) { oldValue, newValue in
                        countPercent()
                        print("totalDuration: \(totalDuration)")
                        print("TimeRemaining: \(newValue)")
                        print("NewValue: \(CGFloat(1 - (newValue / totalDuration)))")
                    }
            }
    }
    
    private func countPercent() {
        let percent = 1.0 - (timeRemaining / totalDuration)
        self.percent = max(0, min(100, percent * 100))
    }
    
    private func formattedTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02D:%02D", minutes, seconds)
    }
}

#Preview {
    CircularProgressView(timeRemaining: 20, totalDuration: 20)
}
