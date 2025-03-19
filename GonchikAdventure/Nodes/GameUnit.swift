//
//  Created by Миляев Максим on 10.03.2025.
//

//import Foundation
import GameplayKit
import SpriteKit

class GameUnit: SKSpriteNode{
 
    var direction: UnitDirection = .left
    
    var horizontalMoveState: UnitHState = .idle
    var verticalMoveState: UnitVState = .onGround

    var horizontalVelocity: CGFloat = 2.0
    var verticalVelocity: CGFloat = 0.0
    var vAccelerate: CGFloat = 0.0
    var vDecelerate: CGFloat = 0.0
    
    var stateMachine: GKStateMachine?
    
    //Textures
    var idleTextures: [SKTexture] = {
        var array = [SKTexture]()
        (0...11).forEach { num in
            array.append(SKTexture(imageNamed: "teddy_idle_\(num)"))
        }
        return array
    }()
    var moveLeftTextures: [SKTexture] = {
        var array = [SKTexture]()
        (0...11).forEach { num in
            array.append(SKTexture(imageNamed: "teddy_walk_\(num)"))
        }
        return array
    }()
    var jumpBeginTextures: [SKTexture] = {
        var array = [SKTexture]()
        (0...7).forEach { num in
            array.append(SKTexture(imageNamed: "teddy_jumpThrow_\(num)"))
        }
        return array
    }()
    var jumpUpTextures: [SKTexture] = {
        var array = [SKTexture]()
        (0...2).forEach { num in
            array.append(SKTexture(imageNamed: "teddy_jumpUp_\(num)"))
        }
        return array
    }()
    var jumpDownTextures: [SKTexture] = {
        var array = [SKTexture]()
        (0...4).forEach { num in
            array.append(SKTexture(imageNamed: "teddy_jumpFall_\(num)"))
        }
        return array
    }()
    
    //
    func setup(){
        self.size = CGSize(width: 64, height: 64)
        self.texture = SKTexture(imageNamed: "teddy_idle_0")
        self.setupStateMachine()
        self.stopAnimation()
    }
    
    func setupPhysics(){
        physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "teddy_idle_0"), size: CGSize(width: 64, height: 64))
        physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        physicsBody?.density = 10 //плотность
        physicsBody?.isDynamic = true
        physicsBody?.friction = 0.2 //сопротивление
        
        physicsBody?.linearDamping = 0 //затухание линейной скорости
        physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        //своя категория
        physicsBody?.contactTestBitMask = /*PhysicsCategory.Obstacle |*/ PhysicsCategory.Edges
        //с какой категорией проводится тест на контакт при симуляции физики
        
        physicsBody?.collisionBitMask = PhysicsCategory.Obstacle
        // контакт с какой категорией влияет на это тело, по умоланию все категории

    }
    
    func setupStateMachine(){
//        let normalState = UnitNormalState(unit: self)
//        stateMachine = GKStateMachine(states: [normalState])
//        stateMachine?.enter(UnitNormalState.self)
    }
    
    func changeDirection(){
        scale(to: CGSize(width: direction == .left ? -size.width: size.width, height: size.height))
        position = CGPoint(x: position.x + (direction == .left ? -size.width / 4: size.width / 4),
                           y: position.y)
    }
    
    func moveRight(){
        if direction != .right{
            changeDirection()
            direction = .right
            moveRight()
        }
        horizontalMoveState = .moveRight
//        if verticalMoveState == .onGround{
//            run(SKAction.repeatForever(SKAction.animate(with: moveLeftTextures, timePerFrame: 0.035)))
//        }
//        physicsBody?.velocity = horizontalVelocity
        position = CGPoint(x: position.x + horizontalVelocity,
                           y: position.y)

    }
    
    func moveLeft(){
        if direction != .left{
            changeDirection()
            direction = .left
            moveLeft()
        }
        horizontalMoveState = .moveLeft
//        if verticalMoveState == .onGround{
//            run(SKAction.repeatForever(SKAction.animate(with: moveLeftTextures, timePerFrame: 0.035)))
//        }
//        physicsBody?.velocity = horizontalVelocity * (-1.0)
        position = CGPoint(x: position.x - horizontalVelocity,
                           y: position.y)
    }
    
    func startJump(){
        self.verticalMoveState = .jump
        let jumpUpAction = SKAction.animate(with: self.jumpUpTextures, timePerFrame: 0.1)
        let fallAction = SKAction.repeatForever(SKAction.animate(with: jumpDownTextures, timePerFrame: 0.1))
        run(SKAction.sequence([jumpUpAction,
                               SKAction.wait(forDuration: 0.03),
                               fallAction]))
//            self.physicsBody?.velocity = self.verticalVelocity
        
    }
//    func startFall(){
//        verticalMoveState = .fall
////        self.physicsBody?.velocity = (self.verticalVelocity * (-1))
//        run(SKAction.animate(with: jumpDownTextures, timePerFrame: 0.1))
//    }
 
    func jump(){
        switch verticalMoveState {
            case .jump, .fall : return
            default: startJump()
        }
    }
    func fall(){
        verticalMoveState = .fall
        physicsBody?.velocity.dy = -9.8
    }
    
    func stopAnimation(){
        run(SKAction.repeatForever(SKAction.animate(with: idleTextures, timePerFrame: 0.1)))
    }

    
    func stopMoving(){
        if verticalMoveState == .onGround , horizontalMoveState == .idle{
            physicsBody?.velocity = CGVector.zero
            stopAnimation()
        }
    }
    
    func acceptCompenstionVelosity(compenstionVelocity: CGVector){
//        let vel = compenstionVelocity * (-1)
//        physicsBody?.velocity += vel
//        if horizontalMoveState == .moveLeft{
//            physicsBody?.velocity = horizontalVelocity * (-1)
//        } else if horizontalMoveState == .moveRight{
//            physicsBody?.velocity = horizontalVelocity
//        }
//        print("new velocity = \(physicsBody?.velocity)")
    }

}


