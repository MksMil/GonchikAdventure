//
//  Created by Миляев Максим on 10.03.2025.
//

import Foundation
import SpriteKit

class GameUnit: SKSpriteNode{
    var state: UnitState = .stop
    
    func setupPhysics(){
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        physicsBody?.density = 1 //плотность
        physicsBody?.isDynamic = true
        physicsBody?.friction = 0 //сопротивление
        
        physicsBody?.linearDamping = 0 //затухание линейной скорости
        physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player //своя категория
        physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges //с какой категорией проводится тест на контакт при симуляции физики
        
        physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges // контакт с какой категорией влияет на это тело, по умоланию все категории
        
        
    }
    
    func moveRight(){
        state = .moveRight
//        physicsBody?.friction = 0
        physicsBody?.applyForce(CGVector(dx: 450, dy: 0.0))
        
    }
    
    
    func moveLeft(){
        state = .moveLeft
//        physicsBody?.applyForce(CGVector(dx: -450, dy: 0.0))
        physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0.0))
    }
    
    func jump(){
        physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 15.0))
    }
    
    func stopMoving(){
        physicsBody?.velocity = CGVector.zero
        state = .stop
    }
}
