//
//  UnitJumpState.swift
//  GonchikAdventure
//
//  Created by Миляев Максим on 19.03.2025.
//

import GameplayKit
import SpriteKit

class UnitJumpState: GKState{
    var unit: UnitModel
    
    init(unit: UnitModel) {
        self.unit = unit
    }
    
    override func didEnter(from previousState: GKState?) {
        print("enter move right")
//        unit.hState = .moveRight
        unit.vState = .jump
//        if let previousState, previousState is UnitHLeftVIdleState{
//            //do smthng
//        }
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
