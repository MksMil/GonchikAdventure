//
//  Created by Миляев Максим on 14.03.2025.
//

import Foundation
import SpriteKit

class ObstacleNode: SKSpriteNode{
    
    func setup(texture: SKTexture, size: CGSize){
        self.texture = texture
        self.size = size
        setupPhysics(texture: texture)
        zPosition = 20
    }
    
    func setupPhysics(texture: SKTexture){
        
        physicsBody = SKPhysicsBody(texture: texture,
                                    size: CGSize(width: texture.size().width,
                                                 height: texture.size().height))

        physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        physicsBody?.density = 1 //плотность
        physicsBody?.isDynamic = false
        physicsBody?.isResting = true
        physicsBody?.friction = 0.2 //сопротивление
        physicsBody?.affectedByGravity = false
        physicsBody?.linearDamping = 0 //затухание линейной скорости
        physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        physicsBody?.allowsRotation = false
//        let rect = SKShapeNode(rectOf: CGSize(width: 64, height: 64))
//        rect.strokeColor = .red
//        addChild(rect)
        physicsBody?.categoryBitMask = PhysicsCategory.Obstacle //своя категория
        physicsBody?.contactTestBitMask = PhysicsCategory.Player //с какой категорией проводится тест на контакт при симуляции физики
        
        /*physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges*/ // контакт с какой категорией влияет на это тело, по умоланию все категории
    }
    
    
}
