//
//  VideoPlayerView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 07.03.24.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    var url: String
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        let player = VideoPlayerUIView(frame: .zero)
        player.launchVideo(url: url)
        return player
    }
}
