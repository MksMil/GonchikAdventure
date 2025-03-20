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
    
    override func willExit(to nextState: GKState) {}
    
    override func update(deltaTime seconds: TimeInterval) {}
}

