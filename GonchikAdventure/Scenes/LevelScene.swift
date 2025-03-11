//
//  LevelScene.swift
//  GonchikAdventure
//
//  Created by Миляев Максим on 10.03.2025.
//

import SwiftUI
import SpriteKit

class LevelScene: RootScene{
    
    enum LevelScneState {
        case paused, playing
    }
    
    enum CameraPositionState: String {
        case nearEdge, idle
    }
    // last update scene time
    var lastUpdateTime: TimeInterval = 0
    
    // delta between lastUpdate
    var dt: TimeInterval = 0
    
    var sceneState: LevelScneState = .playing
    var mainHeroNode: GameUnit = GameUnit()
    
    
    var bgSize: CGSize = CGSize.zero
    var cameraScaleFactor: CGFloat = 1
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        scaleMode = .aspectFill
        createSceneContents()
        setupLevel()
        setupCamera()
    }

    //camera & hud
    func setupCamera(){
        
        let cameraNode = SKCameraNode()
        cameraNode.name = NodeNames.camera.name

        let hudNode = PlayLevelHudNode(withCameraSize: size)
        hudNode.zPosition = 10
        cameraNode.addChild(hudNode)
        
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
        makeCameraConstraints()
    }
    
    func makeCameraConstraints(){
        if let camera {
            camera.constraints = [
                SKConstraint.positionX(SKRange(lowerLimit: size.width  / 2, upperLimit: bgSize.width - size.width / 2),
                                       y: SKRange(lowerLimit: size.height / 2, upperLimit: bgSize.height - size.height / 2))
            ]
        }
    }
    
    func setupLevel(){
        //add bg
        addBG()
        //add obstacles
        addLevelObstacles()
        //setup physics
        setupPhysics()
        //add mainUnit
        addMainHero()
    }
    
    func addBG(){
        let bgNode = SKSpriteNode(color: .blue,
                                  size:  CGSize(width: size.width  - 100,
                                                height:  size.height  - 100))
        bgNode.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: (-size.width + 100) / 2, y: (-size.height + 100) / 2), size: CGSize(width: size.width - 100 , height: size.height - 100)))
        bgNode.physicsBody?.categoryBitMask = PhysicsCategory.Edges
//        bgNode.physicsBody?.contactTestBitMask = PhysicsCategory.Edges
        bgNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(bgNode)
        bgSize = bgNode.size
    }
    
    func addLevelObstacles(){
        let rect = SKSpriteNode(color: .green, size: CGSize(width: 500, height: 10))
        rect.physicsBody = SKPhysicsBody(rectangleOf: rect.size)
        rect.position = CGPoint(x: size.width / 2,
                                y: size.height * 2 / 5)
        rect.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        rect.zPosition = 1
        rect.physicsBody?.isDynamic = false
//        rect.physicsBody?.isResting = true
//        rect.physicsBody?.affectedByGravity = true
        addChild(rect)
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        
       
    }
    
    func createSceneContents() {
        self.backgroundColor = .orange
//        self.scaleMode = .aspectFit
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width * 2, height: size.height * 2 ))
    }
    
    func addMainHero(){
        let texture = SKTexture(vectorNoiseWithSmoothness: 1, size: CGSize(width: 30, height: 30))
        let mainHero = GameUnit(texture: texture, color: .red, size: CGSize(width: 30, height: 30))
        mainHeroNode = mainHero
        mainHero.zPosition = 2
        mainHero.position = CGPoint(x: size.width / 2,
                                    y: size.height / 2)
        mainHero.name = NodeNames.mainHero.name
        mainHero.setupPhysics()
        
        addChild(mainHero)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
//        if lastUpdateTime > 0 {
//            dt = currentTime - lastUpdateTime
//        } else {
//            dt = 0
//        }
//        lastUpdateTime = currentTime
//        
//        switch mainHeroNode.state {
//            case .moving:
//                print("moving")
//            case .stop:
//                print("stop")
//            case .accelerate:
//                print("accelerate")
//            case .decelerate:
//                print("decelerate")
//            case .jumping:
//                print("jumping")
//            case .falling:
//                print("falling")
//        }
    }
}

// MARK: - Touches
extension LevelScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node is BaseButtonNode{
            (node as! BaseButtonNode).changeState()
            if let name = node.name, let nodeName = NodeNames(rawValue: name){
//                print(nodeName.name + "started")
                switch nodeName {
                    case .camera:
                        print("")
                    case .bg:
                        print("")
                    case .startButton:
                        print("")
                //
                    case .buttonLeft:
                        pressLeft()
                    case .buttonRight:
                        pressRight()
                    case .buttonUp:
                        print("")
                    case .buttonDown:
                        print("")
                    case .buttonA:
                        pressA()
                    case .buttonB:
                        pressB()
                //
                    case .buttonPauseResume:
                        print("")
                    case .buttonSpecail:
                        print("")
                    case .labelScores:
                        print("")
                    case .labelLives:
                        print("")
                    case .mainHero:
                        print("main hero")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
//        if let name = node.name{
//            print(name + "ended")
//        }
        if node is BaseButtonNode{
            (node as! BaseButtonNode).changeState()
            if let name = node.name, let nodeName = NodeNames(rawValue: name){
//                print(nodeName.name + "started")
                switch nodeName {
                    case .camera:
                        print("")
                    case .bg:
                        print("")
                    case .startButton:
                        print("")
                //
                    case .buttonLeft:
                        stopMoving()
                    case .buttonRight:
                        stopMoving()
                    case .buttonUp:
                        print("")
                    case .buttonDown:
                        print("")
                    case .buttonA:
                        pressA()
                    case .buttonB:
                        pressB()
                //
                    case .buttonPauseResume:
                        print("")
                    case .buttonSpecail:
                        print("")
                    case .labelScores:
                        print("")
                    case .labelLives:
                        print("")
                    case .mainHero:
                        print("main hero")
                }
            }
        }
    }
}

// MARK: - HudDelegeteProtocol
extension LevelScene: HudDelegateProtocol{
    
    func stopMoving(){
        mainHeroNode.stopMoving()
    }
    
    func pressLeft() {

        
//        camera?.run(SKAction.moveTo(x: round(mainHeroNode.position.x - size.width / 4), duration: 0.2))
        mainHeroNode.moveLeft()
//        camera?.run(SKAction.moveBy(x: -30, y: 0, duration: 0.2))
    }
    
    func pressRight() {
                

//        camera?.run(SKAction.moveTo(x: round(mainHeroNode.position.x + size.width / 4), duration: 0.2))
//        let newLocation = CGPoint(x: round(mainHeroNode.position.x + 30),
//                                  y: mainHeroNode.position.y)
//        
//        mainHeroNode.run(SKAction.move(to: newLocation,
//                                       duration: 0.2))
        mainHeroNode.moveRight()
        camera?.run(SKAction.moveBy(x: 30, y: 0, duration: 0.2))

    }
    
    func pressA() {
//        print("press A action")
        mainHeroNode.jump()
    }
    
    func pressB() {
        print("press B action")
    }
    
    func pressSpecial() {
        
    }
    
    func pauseResume() {
        
    }
}

// MARK: - PhysicsContactDelegate
extension LevelScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        //print("collision begin: normal - \(contact.contactNormal), point: \(contact.contactPoint), mainHeroPoint: \(mainHeroNode.position), impulse: \(contact.collisionImpulse)")
//using contactNormal we can depend where collision was made dy=1: down, dy=-1: up,
// dx=1: left, dx=-1: right
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let normal = contact.contactNormal
        switch normal {
            default : break
        }
        
        if collision == (PhysicsCategory.Player | PhysicsCategory.Obstacle)   {
            mainHeroNode.stopMoving()
        } else if collision == (PhysicsCategory.Player | PhysicsCategory.Edges)   {
            mainHeroNode.stopMoving()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsCategory.Player | PhysicsCategory.Obstacle {
        }
    }
}


#Preview {
    StartView()
}
