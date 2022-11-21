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
    @State var showMenu = false
    var body: some View {
        //ARViewContainer().edgesIgnoringSafeArea(.all)
        let drag = DragGesture()
         .onEnded{
         if $0.translation.width < -100 {
         withAnimation{
         self.showMenu = false
         }
         }
         }
         return NavigationView {
         GeometryReader { geometry in
         ZStack(alignment: .leading) {
         
         ARViewContainer(showMenu: self.$showMenu)
         .frame(width: geometry.size.width, height: geometry.size.height)
         .offset(x: self.showMenu ? geometry.size.width/2 : 0)
         .disabled(self.showMenu ? true : false)
         if self.showMenu {
         Menu()
         .frame(width: geometry.size.width/2)
         .transition(.move(edge: .leading))
         }
         
         }
         .gesture(drag)
         .toolbar {
         ToolbarItemGroup(placement: .navigationBarLeading) {
         Button(action: {
         withAnimation{
         self.showMenu = true
         }
         }) {
         Image(systemName: "line.horizontal.3")
         }
         }
         ToolbarItemGroup(placement: .navigationBarTrailing){
         Button(action: {
         withAnimation{
         self.showMenu = true
         }
         }) {
         Image(systemName: "gear")
         }
         }
         }
         //.toolbarBackground(.hidden, for: .navigationBar)
         }
         
         }
         
         }
        // SettingsView()
    }
    
}

extension ARView {
    
    //Setup AR config
    func setupConfiguration() {
        self.automaticallyConfigureSession = true
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if
            ARWorldTrackingConfiguration
                .supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
    }
    
    //add gesture recognizer to enable removal
    func enableObjectRemoval() {
        let longPressGestRecog = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestRecog)
    }
    
    func enableObjectAdd() {
        let tapGestRecog = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestRecog)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            let position = simd_make_float3(firstResult.worldTransform.columns.3)
            
            let model = retrieveModel()
            
            self.installGestures([.translation, .rotation], for: model)
            
            placeObject(modelEntity: model, at: position)
        }
        
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
    
    /*
     Load entity, generate collision shape and
     return it
    */
    
    func retrieveModel() -> ModelEntity {
        let modelEntity = try! ModelEntity.loadModel(named: "chair_swan.usdz")
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        return modelEntity
    }
    
    /*
     Place anchor at location, give it
     a name for removal and add model to it
    */
    
    func placeObject(modelEntity:ModelEntity, at location:SIMD3<Float>) {
        let anchor = AnchorEntity(world: location)
        
        anchor.name = "chairAnchor"
        
        anchor.addChild(modelEntity)
        
        self.scene.anchors.append(anchor)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var showMenu: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        arView.setupConfiguration()
        
        arView.enableObjectAdd()
        
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
