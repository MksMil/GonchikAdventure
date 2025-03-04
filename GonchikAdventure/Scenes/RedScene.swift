import SwiftUI
import SpriteKit

class RedScene: RootScene {
    
    let cameraNode = SKCameraNode()
    var bgNode: SKNode = SKNode()
    var startButton = SKNode()
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        scaleMode = .aspectFill
        
        setupCamera()
        addStartButton()
        
    }
    
    func setupCamera(){
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
    }
    
    func addStartButton(){
        let texture =  SKTexture(imageNamed: "stattButton")
        startButton = SKSpriteNode(texture: texture, size: CGSize(width: 300, height: 300))
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
        if node == startButton{
            print("start touched")
            mainViewDelegate?.printText(text: "Hello!!!")
            mainViewDelegate?.nextScene()
        }
    }
    
    
    
    
    
    
}
