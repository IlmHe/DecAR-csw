//
//  ContentView.swift
//  DecAR
//
//  Created by iosdev on 16.11.2022.
//
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

extension ARView {
    
    //add gesture recognizer to enable removal
    func enableObjectRemoval() {
        let longPressGestRecog = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestRecog)
    }
    
    
    //Find location and remove anchor from object
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        if let modelEntity = self.entity(at: location) {
            if let anchorEntity = modelEntity.anchor, anchorEntity.name == "chairAnchor" {
                anchorEntity.removeFromParent()
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if
            ARWorldTrackingConfiguration
                .supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
        
        /*
         Create anchor in horizontal plane, give it
         a name for removal
        */
        let anchor = AnchorEntity(plane: .horizontal)
        
        anchor.name = "chairAnchor"
        
        /*
         Load entity, generate collision shape
         and install tanslation, rotation gestures
         for entity (for some reason also gives scaling as of now)
        */
        let modelEntity = try! ModelEntity.loadModel(named: "chair_swan.usdz")
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.translation, .rotation], for: modelEntity)
        
        
        
        anchor.addChild(modelEntity)
        
        arView.scene.anchors.append(anchor)
        
        arView.enableObjectRemoval()
         
        return arView

    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
