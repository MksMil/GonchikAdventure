import SwiftUI
import SpriteKit

class HomeScene: RootScene {
  
    override func didMove(to view: SKView) {
        size = view.frame.size
        scaleMode = .aspectFill
        
        setupCamera()
        addBG()
        addStartButton()
        
    }
    
    func setupCamera(){
    let cameraNode = SKCameraNode()
        cameraNode.name = NodeNames.camera.name
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
    }
    
    func addBG(){
        let bgNode = MainMenuBackgroundNode(withSize: size)
        bgNode.name = NodeNames.bg.name
        addChild(bgNode)
    }
    
    func addStartButton(){
        let texture =  SKTexture(imageNamed: "stattButton")
        
        let startButton = SKSpriteNode(texture: texture, size: CGSize(width: 300, height: 300))
        startButton.name = NodeNames.startButton.name
        addChild(startButton)
        startButton.position = CGPoint(x: size.width / 2,
                                       y: size.height / 2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        //removing moving gap
        let node = atPoint(location)

        //if sprite touched define shapenode to selected node
        if let name = node.name, name == NodeNames.startButton.name{
            mainViewDelegate?.presentScene( .levelScene)
        }
    }
}

#Preview {
    StartView()
}
