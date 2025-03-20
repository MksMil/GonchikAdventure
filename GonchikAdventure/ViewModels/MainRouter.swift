import SpriteKit
import SwiftUI
import GameplayKit

final class MainRouter: ObservableObject, MainViewDelegateProtocol{
    
    var activeScene: RootScene = RootScene()
    
    // MARK: - Init
    init() {
        self.activeScene = loadScene(name: "TestScene")
        
    }
    
//initial load
    func loadScene(name: String) -> RootScene{
        
        if let scene = GKScene(fileNamed: "TestScene"){
            if let sceneNode = scene.rootNode as? LevelScene {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.mainViewDelegate = self
                return sceneNode
            }else{
                //debug
                return HomeScene() //error scene mb?
            }
        }
        else{
            //debug
            print("gkscn not loaded")
            return HomeScene() //error scene mb?
        }
        
    }
}

// MARK: - MainViewDelegateProtocol
extension MainRouter{
    func presentScene(_ scene: ScenePath) {

       let newScene = loadScene(name: scene.rawValue)
        newScene.mainViewDelegate = self
        activeScene.view?.presentScene(newScene, transition: .crossFade(withDuration: 1))
        activeScene = newScene
    }
}
