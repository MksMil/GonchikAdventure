import SwiftUI
import SpriteKit

class PlayLevelHudNode: SKNode{
    
//    weak var hudDelegate: HudDelegateProtocol?
    var size: CGSize
    let scaleFactor: CGFloat = 1 / 10
    let buttonSize: CGFloat = 1 / 10
    
    init(withCameraSize size: CGSize) {
        self.size = size
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    //buttons left, right, up, down, a, b, pause/resume, special
    // labels
    func setup(){
        //left button
        let leftButtonNode = BaseButtonNode()
        leftButtonNode.setup(withName: "silver-!arrowleft",
                             size: CGSize(width: size.width * buttonSize,
                                          height: size.width * buttonSize),
                             position: CGPoint(x: -size.width * 3.7 * scaleFactor,
                                               y: -size.height * 3.5 * scaleFactor))
        leftButtonNode.changeState()
        leftButtonNode.name = NodeNames.buttonLeft.name
        
        
        //right button
        let rightButtonNode = BaseButtonNode()// "silver-!arrowright"
        rightButtonNode.setup(withName: "silver-!arrowright",
                              size: CGSize(width: size.width * buttonSize,
                                           height: size.width * buttonSize),
                              position: CGPoint(x: -size.width * 2.7 * scaleFactor,
                                                y: -size.height * 3.5 * scaleFactor))
        rightButtonNode.name = NodeNames.buttonRight.name
        rightButtonNode.changeState()
        
        //a button
        let aButtonNode = BaseButtonNode()// "silver-A"
        aButtonNode.setup(withName: "silver-A",
                          size: CGSize(width: size.width * buttonSize,
                                       height: size.width * buttonSize),
                          position: CGPoint(x: size.width * 2.7 * scaleFactor,
                                            y: -size.height * 3.5 * scaleFactor))
        aButtonNode.name = NodeNames.buttonA.name
        aButtonNode.changeState()
        
        //b button
        
        let bButtonNode = BaseButtonNode() //"silver-B"
        bButtonNode.setup(withName: "silver-B",
                          size: CGSize(width: size.width * buttonSize,
                                       height: size.width * buttonSize),
                          position: CGPoint(x: size.width * 3.7 * scaleFactor,
                                            y: -size.height * 3.25 * scaleFactor))
        bButtonNode.name = NodeNames.buttonB.name
        bButtonNode.changeState()
        
        
        
        addChild(leftButtonNode)
        addChild(rightButtonNode)
        addChild(aButtonNode)
        addChild(bButtonNode)
    }
    
    func updateWithSize(_ size: CGSize) {
        
    }
}

#Preview {
    StartView()
}
