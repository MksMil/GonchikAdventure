import SwiftUI
import SpriteKit

class HomeScene: SKScene {
    
    let cameraNode = SKCameraNode()
    var bgNode: SKNode = SKNode()
    var startButton = SKNode()
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        scaleMode = .aspectFill
        
        setupCamera()
        addBG()
        addStartButton()
    }
    
    func setupCamera(){
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
    }
    
    func addBG(){
        bgNode = BackgroundNode(withSize: size)
        addChild(bgNode)
    }
    
    func addStartButton(){
        startButton = SKSpriteNode(texture: SKTexture(imageNamed: "stattButton"))
        addChild(startButton)
        startButton.position = CGPoint(x: size.width / 2,
                                       y: size.height / 2)
        startButton.setScale(0.2)
    }
    
    
    
    
}

#Preview {
    ContentView()
}
