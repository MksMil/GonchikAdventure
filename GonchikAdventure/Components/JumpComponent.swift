//
//  JumpComponent.swift
//  GonchikAdventure
//
//  Created by Миляев Максим on 19.03.2025.
//

import GameplayKit
import SpriteKit

class JumpComponent: GKComponent{
    var node: SKSpriteNode
    var unit: UnitModel
    
    init(node: SKSpriteNode, unit: UnitModel) {
        self.node = node
        self.unit = unit
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds) //?
        var dx: CGFloat = .zero
        var dy: CGFloat = .zero
        switch unit.hState {
            case .moveLeft:
                dx = -unit.horizontalSpeed
            case .moveRight:
                dx = unit.horizontalSpeed
            case .idle:
                dx = 0
        }
        switch unit.vState {
            case .jump:
                //calculate new vertical position
            case .fall:
                
            case .onGround:
                
        }
        node.position = CGPoint(x: node.position.x + dx,
                                y: node.position.y + dy)
        
    }
    
    
}
