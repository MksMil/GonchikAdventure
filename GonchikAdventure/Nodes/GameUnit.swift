//
//  Created by Миляев Максим on 10.03.2025.
//

//import Foundation
import SpriteKit

class GameUnit: SKSpriteNode{
    //testing var
    var startJumpValue: Date = Date()
    var endJumpValue: Date = Date()
    
    enum HeroDirection {
        case left, right
    }
    
    enum HorizontalMoveState{
        case moveLeft, moveRight, idle
    }
    enum VerticalMoveState{
        case jump, fall, onGround
    }
    
    var direction: HeroDirection = .left
    var horizontalMoveState: HorizontalMoveState = .idle
    {
        willSet{
            print("horiz:" + "\(newValue)")
        }
    }
    var verticalMoveState: VerticalMoveState = .onGround
    {
        willSet{
            print("vertical:" + "\(newValue)")
        }
    }
    
    var horizontalVelocity: CGVector = CGVectorMake(250, 0)
    var verticalVelocity: CGVector = CGVectorMake(0, 600)
    
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
    
    func setup(){
        self.size = CGSize(width: 64, height: 64)
        self.texture = SKTexture(imageNamed: "teddy_idle_0")
        self.stopAnimation()
    }
    
    func setupPhysics(){
        physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "teddy_idle_0"), size: CGSize(width: 64, height: 64))
//        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50))
//        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody?.restitution = 0 //отскок(упругость) [0:1] 0 - не отскакиевает
        physicsBody?.density = 1 //плотность
        physicsBody?.isDynamic = true
        physicsBody?.friction = 0.2 //сопротивление
        
        physicsBody?.linearDamping = 0.1 //затухание линейной скорости
        physicsBody?.angularDamping = 0 //затухание угловой скорости
        
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        //своя категория
        physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges
        //с какой категорией проводится тест на контакт при симуляции физики
        
        physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Edges
        // контакт с какой категорией влияет на это тело, по умоланию все категории

    }
    
    func changeDirection(){
        let turnAction = SKAction.scaleX(by: -1,y: 1, duration: 0.01)
        let chAction = SKAction.moveBy(x: size.width * (direction == .left ? (-1):1) / 3,
                                       y: 0, duration: 0.01)
        run(SKAction.group([turnAction, chAction]))
    }
    
    func moveRight(){
        if direction != .right{
            changeDirection()
            direction = .right
            moveRight()
        }
        horizontalMoveState = .moveRight
        if verticalMoveState == .onGround{
            run(SKAction.repeatForever(SKAction.animate(with: moveLeftTextures, timePerFrame: 0.035)))
        }
        physicsBody?.velocity = horizontalVelocity

    }
    
    func moveLeft(){
        if direction != .left{
            changeDirection()
            direction = .left
            moveLeft()
        }
        horizontalMoveState = .moveLeft
        if verticalMoveState == .onGround{
            run(SKAction.repeatForever(SKAction.animate(with: moveLeftTextures, timePerFrame: 0.035)))
        }
        physicsBody?.velocity = horizontalVelocity * (-1.0)
    }
    
    func startJump(){
        self.verticalMoveState = .jump
        let jumpUpAction = SKAction.animate(with: self.jumpUpTextures, timePerFrame: 0.1)
        let fallAction = SKAction.repeatForever(SKAction.animate(with: jumpDownTextures, timePerFrame: 0.1))
        run(SKAction.sequence([jumpUpAction,
                               SKAction.wait(forDuration: 0.03),
                               fallAction]))
            self.physicsBody?.velocity = self.verticalVelocity
        
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
        if horizontalMoveState == .moveLeft{
            physicsBody?.velocity = horizontalVelocity * (-1)
        } else if horizontalMoveState == .moveRight{
            physicsBody?.velocity = horizontalVelocity
        }
//        print("new velocity = \(physicsBody?.velocity)")
    }
    
//    func stopHorizontalMoving(){
//        physicsBody?.velocity.dx = 0
//    }
}


