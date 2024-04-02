//
//  TeaImmersiveView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 21.03.24.
//

import SplineRuntime
import SwiftUI


#if os(visionOS)
struct TeaImmersiveView: ImmersiveSpaceContent {
    
    var body: some ImmersiveSpaceContent {
        // fetching from cloud
        let url = URL(string: "https://build.spline.design/D2Tjq3QKLddRontn1W0J/scene.splineswift")!

        // // fetching from local
        // let url = Bundle.main.url(forResource: "scene", withExtension: "splineswift")!

        SplineImmersiveSpaceContent(sceneFileURL: url)
    }
}

#endif
