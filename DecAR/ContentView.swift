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
    @State var showFurMenu = false
    @State var showSettings = false

    //Coredata
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        //ARViewContainer().edgesIgnoringSafeArea(.all)
        let drag = DragGesture()
         .onEnded {
             if $0.translation.width < -100 {
                withAnimation{
                    self.showMenu = false
                }
             }
         }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    //Color.purple
                    ARViewContainer(showMenu: self.$showMenu, showFurMenu: self.$showFurMenu, showSettings: self.$showSettings)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        //.offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                        //.offset(x: self.showSettings ? -geometry.size.width/2 : 0)
                        .disabled(self.showSettings ? true : false)
                        .edgesIgnoringSafeArea(.all)
                        
                    if self.showMenu {
                        Menu()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                    
                    if !self.showMenu && !self.showSettings && self.showFurMenu {
                        FurnitureMenu()
                            .transition(.move(edge: .bottom))
                    }
                    
                    if !self.showMenu && !self.showFurMenu && self.showSettings {
                        Settings()
                            .offset(x: geometry.size.width/2)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .trailing))
                    }
                    
                }
                .gesture(drag)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if !self.showFurMenu {
                            Button(action: {
                                if !self.showMenu {
                                    withAnimation{
                                        self.showMenu = true
                                    }
                                } else {
                                    withAnimation{
                                        self.showMenu = false
                                    }
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                            }
                        }

                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        if !self.showFurMenu {
                            Button(action: {
                                if !self.showSettings {
                                    withAnimation{
                                        self.showSettings = true
                                    }
                                } else {
                                    withAnimation{
                                        self.showSettings = false
                                    }
                                }
                            }) {
                                Image(systemName: "gear")
                            }
                        }
                        
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        if !(self.showFurMenu || self.showMenu) {
                            Button(action: {
                                withAnimation{
                                    self.showFurMenu = true
                                }
                            }) {
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                            }
                        }
                    }
                    
                }//.toolbarBackground(.hidden, for: .navigationBar)
            }
            
        }
        
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
        let modelEntity = try! ModelEntity.loadModel(named: "Stool_6.usdz")
        
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
    @Binding var showFurMenu: Bool
    @Binding var showSettings: Bool
    
    
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
