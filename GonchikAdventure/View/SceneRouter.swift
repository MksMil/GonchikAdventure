import SwiftUI
import SpriteKit

final class SceneRouter: ObservableObject, MainViewDelegateProtocol {

    var activeScene: RootScene
    var isRed: Bool = false
    
    init() {
        self.activeScene = HomeScene()
        activeScene.mainViewDelegate = self
    }
    
    
    func changeScene(scene: RootScene){
        scene.mainViewDelegate = self
        
        if let view  = activeScene.view{
            
            view.presentScene(scene)
            activeScene = scene
        } else {
            print("error change ")
        }
//        activeScene.view?.presentScene(scene)
        
    }
    
    func printText(text: String) {
        print(text)
    }
    func nextScene(){
        print("nextScene loaded")
        if isRed {
            print("home")
            changeScene(scene: HomeScene())
        } else{
            print("red")
            changeScene(scene: RedScene())
        }
        
        isRed.toggle()
        print(isRed)
    }
    
}

#Preview {
    ContentView()
}
