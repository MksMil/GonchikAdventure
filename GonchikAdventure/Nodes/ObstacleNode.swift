//
//  Created by Миляев Максим on 14.03.2025.
//

//import Foundation
import SpriteKit

class ObstacleNode: SKSpriteNode{
    
    func setup(name: RockTiles){
        texture = SKTexture(imageNamed: name.rawValue)
        self.size = CGSize(width: 64, height: 64)
//        self.texture = SKTexture(imageNamed: "teddy_idle_0")
        setupPhysics(name:name)
        zPosition = 15
    }
    
    func setupPhysics(name: RockTiles){
//        physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: name.rawValue), size: CGSize(width: 64, height: 64))
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 40))
//        SKPhysicBody
        physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        physicsBody?.density = 1 //плотность
        physicsBody?.isDynamic = false
        physicsBody?.isResting = true
        physicsBody?.friction = 0.3 //сопротивление
        physicsBody?.affectedByGravity = false
        physicsBody?.linearDamping = 0 //затухание линейной скорости
        physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        physicsBody?.allowsRotation = false
//        let rect = SKShapeNode(rectOf: CGSize(width: 64, height: 64))
//        rect.strokeColor = .red
//        addChild(rect)
        physicsBody?.categoryBitMask = PhysicsCategory.Obstacle //своя категория
        /*physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges*/ //с какой категорией проводится тест на контакт при симуляции физики
        
        /*physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges*/ // контакт с какой категорией влияет на это тело, по умоланию все категории
    }
    
    
}
