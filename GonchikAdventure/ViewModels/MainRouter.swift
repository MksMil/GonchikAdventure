import SpriteKit
import SwiftUI

final class MainRouter: ObservableObject, MainViewDelegateProtocol{
    
    var activeScene: RootScene

    //init with HomeScene
    init() {
        self.activeScene = LevelScene()//HomeScene()
        self.activeScene.mainViewDelegate = self
    }
    
    
}

// MARK: - MainViewDelegateProtocol
extension MainRouter{
    func presentScene(_ scene: ScenePath) {
        var newScene: RootScene
        switch scene {
            case .levelScene:
                newScene = LevelScene()
            case .home:
                newScene = HomeScene()
        }
        newScene.mainViewDelegate = self
        activeScene.view?.presentScene(newScene, transition: .crossFade(withDuration: 1))
        activeScene = newScene
    }
}
