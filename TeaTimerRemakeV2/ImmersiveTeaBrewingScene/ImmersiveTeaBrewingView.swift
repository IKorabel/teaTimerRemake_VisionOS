//
//  ImmersiveTeaBrewingView.swift
//  TeaTimerRemakeV2
//
//  Created by Igor Shefer on 02.04.24.
//

import RealityKit
import SwiftUI

#if os(visionOS)

struct ImmersiveTeaBrewingView: View {
    
    var body: some View {
        RealityView { content in
            let skybox = createSkybox(immersiveBackground: .mountains)
            content.add(skybox!)
        }
    }
    
    private func createSkybox(immersiveBackground: ImmersiveTeaBrewingBackground) -> Entity? {
        let largeSphere = MeshResource.generateSphere(radius: 3)
        var skyboxMaterial = UnlitMaterial()
        
        do {
            let texture = try TextureResource.load(named: immersiveBackground.assetName)
            skyboxMaterial.color = .init(texture: .init(texture))
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
        
        let skyboxEntity = Entity()
        skyboxEntity.components.set(ModelComponent(mesh: largeSphere, materials: [skyboxMaterial]))
        skyboxEntity.scale = .init(x: -1, y: 1, z: 1)
        return skyboxEntity
    }
}

#Preview {
    ImmersiveTeaBrewingView()
}

#endif
