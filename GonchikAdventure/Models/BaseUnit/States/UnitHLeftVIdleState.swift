//
//  Created by Миляев Максим on 18.03.2025.
//
//

import GameplayKit
import SpriteKit

class UnitHLeftVIdleState: GKState{
    
    var unit: UnitModel
    
    init(unit: UnitModel) {
        self.unit = unit
    }
    
    override func didEnter(from previousState: GKState?) {
        unit.hState = .moveLeft
        unit.vState = .onGround
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
//        print("update in state")
//        if unit.horizontalMoveState == .moveLeft{
//            unit.moveLeft()
//        } else if unit.horizontalMoveState == .moveRight {
//            unit.moveRight()
//        } else {
////            unit.stopMoving()
//        }
//
//        if unit.verticalMoveState == .jump{
//
//        } else if unit.verticalMoveState == .fall{
//
//        } else {
//
//        }
    }
}

