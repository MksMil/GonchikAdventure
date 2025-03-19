//
//  UnitModel.swift
//  GonchikAdventure
//
//  Created by Миляев Максим on 19.03.2025.
//

import GameplayKit

class UnitModel {
    
    var name: String        = "" // enum needed
    var textureName: String = "" // enum needed
    var node: SKSpriteNode = SKSpriteNode()
    
    var lives: Int          = 3
    var scores: Int         = 0
    
    var size: CGSize        = CGSize(width: 64, height: 64)//.zero
    
    var direction: UnitDirection = .left
    var hState: UnitHState       = .idle
    var vState: UnitVState       = .onGround
    
    var horizontalSpeed: CGFloat = 2
    var verticalSpeed: CGFloat = 0.0
    
    var vAccelerate: CGFloat = 0.0
    var vDecelerate: CGFloat = 0.0
    
    var stateMachine: GKStateMachine?
    
    func setupStateMachine(){
        let hIdleVIdleState = UnitHIdleVIdlelState(unit: self)
        let hLeftVIdleState = UnitHLeftVIdleState(unit: self)
        let hRightVIdleState = UnitHRightVIdleState(unit: self)
        let unitJumpState = UnitJumpState(unit: self)
        stateMachine = GKStateMachine(states: [hIdleVIdleState,hLeftVIdleState,hRightVIdleState, unitJumpState])
        stateMachine?.enter(UnitHIdleVIdlelState.self)
    }
    
    func makeEntity()->GKEntity{
        let entity = GKEntity()
        let texture = TextureBank.hero_idleTextures[0]//SKTexture(imageNamed: textureName)
        node = SKSpriteNode(texture: texture, size: size)
        setupPhysicsTo(node: node)
        //add Components?
        let horizontalMoveComponent =  HorizontalMoveComponent(node: node,
                                                               unit: self)
        let vComponent = VisualComponent(unit: self,
                                         node: node)
        let directionComponent = DirectionComponent(node: node,
                                                    unit: self)
        let jumpComponent = JumpComponent(node: node,
                                          unit: self)
        entity.addComponent(vComponent)
        entity.addComponent(horizontalMoveComponent)
        entity.addComponent(directionComponent)
        setupStateMachine()
     
        return entity
    }
    
    func setupPhysicsTo(node: SKSpriteNode){
        node.physicsBody = SKPhysicsBody(texture: TextureBank.hero_idleTextures[0], size: size)
        node.physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        node.physicsBody?.density = 10 //плотность
        node.physicsBody?.isDynamic = true
        node.physicsBody?.friction = 0.2 //сопротивление
        
        node.physicsBody?.linearDamping = 0 //затухание линейной скорости
        node.physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        node.physicsBody?.allowsRotation = false
        
        node.physicsBody?.categoryBitMask = PhysicsCategory.Player
        //своя категория
        node.physicsBody?.contactTestBitMask = /*PhysicsCategory.Obstacle |*/ PhysicsCategory.Edges
        //с какой категорией проводится тест на контакт при симуляции физики
        
        node.physicsBody?.collisionBitMask = PhysicsCategory.Obstacle
        // контакт с какой категорией влияет на это тело, по умоланию все категории

    }
   
}
