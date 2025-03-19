//
//  Created by Миляев Максим on 17.03.2025.
//

import SpriteKit
import GameplayKit

class PlayerControlComponent: GKComponent{
    //input
    var touchInputControlNode: TouchInputControlNode?
    
    //output
    var unitToControl: UnitModel?
    var scene: RootScene?
    var camera: SKCameraNode?
    
    func setup(camera: SKCameraNode,
               size: CGSize,
               unit: UnitModel,
               scene: RootScene){
        touchInputControlNode = TouchInputControlNode(withCameraSize: size)
        self.unitToControl = unit
        self.camera = camera
        self.scene = scene //pause-resume
        touchInputControlNode?.inputDelegate = self
        camera.addChild(touchInputControlNode!)
    }
  
    // MARK: - Update
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        unitToControl?.stateMachine?.update(deltaTime: seconds)
    }
    
    // MARK: - Deinit
    deinit{
        print("PCComponent deinit")
    }
}

extension PlayerControlComponent: ControlInputDelegate{
    func executeInstruction(input: NodeNames, state: InputState) {
        print("button pressed")
        switch input {
//            case .camera:
//                <#code#>
//            case .bg:
//                <#code#>
//            case .startButton:
//                <#code#>
            case .buttonLeft:
                if state == .pressed {
//                    unit?.moveLeft()
                    unitToControl?.stateMachine?.enter(UnitHLeftVIdleState.self)
                } else {
//                    unit?.stopMoving()
                    unitToControl?.stateMachine?.enter(UnitHIdleVIdlelState.self)
                }
            case .buttonRight:
                if state == .pressed {
//                    unit?.moveRight()
                    unitToControl?.stateMachine?.enter(UnitHRightVIdleState.self)
                } else {
//                    unit?.stopMoving()
                    unitToControl?.stateMachine?.enter(UnitHIdleVIdlelState.self)
                }
//            case .buttonUp:
//                <#code#>
//            case .buttonDown:
//                <#code#>
            case .buttonA:
                print("A pressed")
                unitToControl?.stateMachine?.enter(UnitJumpState.self)

            case .buttonB:
                print("B pressed")
//            case .buttonPauseResume:
//                <#code#>
//            case .buttonSpecail:
//                <#code#>
//            case .labelScores:
//                <#code#>
//            case .labelLives:
//                <#code#>
//            case .mainHero:
//                <#code#>
//            case .empty:
//                <#code#>
            default: return
        }
    }
}
