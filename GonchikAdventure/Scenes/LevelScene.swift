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
    enum ButtonState {
        case tapped, untapped
    }
    
    //hud state
    var leftButtonState: ButtonState = .untapped
    {
        willSet{
            mainHeroNode.moveLeft()
        }
    }
    var rightButtonState: ButtonState = .untapped
    {
        willSet{
            mainHeroNode.moveRight()
        }
    }
    var AButtonState: ButtonState = .untapped
    {
        willSet{
            mainHeroNode.jump()
        }
    }
    
    var BButtonState: ButtonState = .untapped
    var pauseButtonState: ButtonState = .untapped
    var specialButtonState: ButtonState = .untapped
    
    // last update scene time
    var lastUpdateTime: TimeInterval = 0
    
    // delta between lastUpdate
    var dt: TimeInterval = 0
    
    var sceneState: LevelScneState = .playing
    var mainHeroNode: GameUnit = GameUnit()
    var bgNode: DungeonBackgroundNode = DungeonBackgroundNode()
    
    var levelSize: CGSize {
        get{
            CGSize(width: size.width * 2, height: size.height * 2)
        }
    }
    var cameraScaleFactor: CGFloat = 1
    
    // MARK: - TestLevel Array
    let lelelObstacles: [[RockTiles]] = [
        Array(repeating: .fullRock, count: 10),
        Array(repeating: .topRock, count: 10),
        [.rightRockEdge],
        [.rightRockEdge],
        Array(repeating: .centerSurface, count: 10),
        Array(repeating: .fullRock, count: 10),
        Array(repeating: .fullRock, count: 10)
    ]
    
    // 🎯 Convenience initializer
        convenience init?(fileNamed: String) {
            guard let scene = SKScene(fileNamed: fileNamed) else { return nil }     
            self.init(size: scene.size)
            scene.children.forEach({addChild($0)})
        }
    // 🎯 Designated initializer
        override init(size: CGSize) {
            super.init(size: size)
        }
        
        // 🎯 Required initializer for NSCoding
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
    
    override func didMove(to view: SKView) {
//        let tileMap = SKTileMapNode(fileNamed: "")
//        size = view.frame.size
//        scaleMode = .aspectFill
////        createSceneContents()
//        setupLevel()
//        setupCamera()
    }

    //camera & hud
    func setupCamera(){
        let cameraNode = SKCameraNode()
        cameraNode.name = NodeNames.camera.name
        let hudNode = PlayLevelHudNode(withCameraSize: size)
        hudNode.zPosition = 100
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
                SKConstraint.positionX(SKRange(lowerLimit: size.width  / 2, upperLimit: bgNode.bounds.size.width - size.width / 2),
                                       y: SKRange(lowerLimit: size.height / 2, upperLimit: bgNode.bounds.height - size.height / 2))
            ]
        }
    }
    
    func setupLevel(){
        addBG()
        addLevelObstacles()
        setupPhysics()
        addMainHero()
    }
    
    func setupLevel(map: SKTileMapNode){
        
    }
    
    func addBG(){
        bgNode.setup(withSize: size,fullSize: levelSize)
//        bgNode.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: (-size.width + 100) / 2, y: (-size.height + 100) / 2), size: CGSize(width: size.width - 100 , height: size.height)))
////        bgNode.physicsBody?.isDynamic = false
//        bgNode.physicsBody?.categoryBitMask = PhysicsCategory.Edges
//        bgNode.physicsBody?.restitution = 0
        bgNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(bgNode)
    }
    
    func addLevelObstacles(){
        let rect = SKSpriteNode(color: .green,
                                size: CGSize(width: 50, height: 10))
        rect.physicsBody = SKPhysicsBody(rectangleOf: rect.size)
        rect.position = CGPoint(x: size.width / 2,
                                y: size.height * 2 / 5)
        rect.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        rect.zPosition = 10
        rect.physicsBody?.isDynamic = false
        rect.physicsBody?.isResting = true
        rect.physicsBody?.affectedByGravity = true
        addChild(rect)
        
        let rect2 = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 10))
        rect2.physicsBody = SKPhysicsBody(rectangleOf: rect2.size)
        rect2.position = CGPoint(x: (size.width / 2) - 60,
                                y: size.height * 2 / 5)
        rect2.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        rect2.zPosition = 10
        rect2.physicsBody?.isDynamic = false
        rect2.physicsBody?.isResting = true
        addChild(rect2)
        
        let rect3 = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 10))
        rect3.physicsBody = SKPhysicsBody(rectangleOf: rect3.size)
        rect3.position = CGPoint(x: (size.width / 2) - 110,
                                y: size.height * 2 / 5)
        rect3.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        rect3.zPosition = 10
        rect3.physicsBody?.isDynamic = false
        rect3.physicsBody?.isResting = true
        addChild(rect3)
        
        
        
        
        for i in lelelObstacles.enumerated(){
            for j in i.element.enumerated(){
                if !j.element.rawValue.isEmpty{
                    let obstacle = ObstacleNode()
                    obstacle.setup(name: j.element)
                    obstacle.name = "\(j.element.rawValue): x: \(j.offset), y:\(i.offset)"
                    obstacle.position = CGPoint(x: CGFloat(64 * j.offset), y: size.height - CGFloat(64 * i.offset))
                    //                print("\(j.element) \(obstacle.position)")
                    addChild(obstacle)
                }
            }
        }
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
    }
    
//    func createSceneContents() {
//        self.backgroundColor = .orange
////        self.scaleMode = .aspectFit
////        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width * 2, height: size.height * 2 ))
//        
//    }
    
    func addMainHero(){
        let mainHero = GameUnit()
        mainHero.setup()
        mainHeroNode = mainHero
        mainHero.zPosition = 20
        mainHero.position = CGPoint(x: size.width / 2,
                                    y: size.height / 2)
        mainHero.name = NodeNames.mainHero.name
        mainHero.setupPhysics()
        
        addChild(mainHero)
        mainHero.stopMoving()
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {

        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        if dt > 0.01{
            bgNode.updateBG(pos: mainHeroNode.position)
        }

    }
}

// MARK: - Touches
extension LevelScene{
    
    // TODO: multiple button touch funcionality
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node is BaseButtonNode{
            (node as! BaseButtonNode).changeState()
            if let name = node.name, let nodeName = NodeNames(rawValue: name){
                switch nodeName {
//                    case .camera:
//                    case .bg:
//                    case .startButton:
                    case .buttonLeft:
                        leftButtonState = .tapped
                    case .buttonRight:
                        rightButtonState = .tapped
//                    case .buttonUp:
//                    case .buttonDown:
                    case .buttonA:
                        AButtonState = .tapped
                    case .buttonB:
                        BButtonState = .tapped
                //
//                    case .buttonPauseResume:
//                        print("")
                    case .buttonSpecail:
                        specialButtonState = .tapped
//                    case .labelScores:
//                        print("")
//                    case .labelLives:
//                        print("")
//                    case .mainHero:
//                        print("main hero")
                    default: break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node is BaseButtonNode{
            (node as! BaseButtonNode).changeState()
            if let name = node.name,
               let nodeName = NodeNames(rawValue: name){
                switch nodeName {
//                    case .camera:
//                        print("")
//                    case .bg:
//                        print("")
                //
//                    case .startButton:
//
//                    case .buttonPauseResume:
                //
                    case .buttonLeft:
                        leftButtonState = .untapped
                        mainHeroNode.horizontalMoveState = .idle
                        stopMoving()
                    case .buttonRight:
                        rightButtonState = .untapped
                        mainHeroNode.horizontalMoveState = .idle
                        stopMoving()
//                    case .buttonUp:

//                    case .buttonDown:
                    case .buttonA:
                        AButtonState = .untapped
//                        pressA()
                    case .buttonB:
                        BButtonState = .untapped
//                        pressB()
//                    case .buttonSpecail:
//                        print("")
                //
//                    case .labelScores:
//                        print("")
//                    case .labelLives:
//                        print("")
                //
//                    case .mainHero:
//                        print("main hero")
                    default: return
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
//        mainHeroNode.moveLeft()
//        camera?.run(SKAction.moveBy(x: -30, y: 0, duration: 0.2))
    }
    
    func pressRight() {
//        camera?.run(SKAction.moveTo(x: round(mainHeroNode.position.x + size.width / 4), duration: 0.2))
//        let newLocation = CGPoint(x: round(mainHeroNode.position.x + 30),
//                                  y: mainHeroNode.position.y)
//        
//        mainHeroNode.run(SKAction.move(to: newLocation,
//                                       duration: 0.2))
//        mainHeroNode.moveRight()
//        camera?.run(SKAction.moveBy(x: 30, y: 0, duration: 0.2))

    }
    
    func pressA() {
//        print("press A action")
//        mainHeroNode.jump()
    }
    
    func pressB() {
//        print("press B action")
    }
    
    func pressSpecial() {
        
    }
    
    func pauseResume() {
        
    }
}

// MARK: - PhysicsContactDelegate
extension LevelScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        //using contactNormal we can depend where collision was made
        // dy ==  1: down,
        // dy == -1: up,
        // dx ==  1: left,
        // dx == -1: right
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let normal = contact.contactNormal
        
//        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player{
//            let contactBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB:contact.bodyA
//        }
        
        if normal.dy > 0, mainHeroNode.verticalMoveState != .onGround{
//            print("begin coll")
            mainHeroNode.verticalMoveState = .onGround
            mainHeroNode.endJumpValue = Date.now
//            print("dif: \(mainHeroNode.startJumpValue.timeIntervalSince1970 - mainHeroNode.endJumpValue.timeIntervalSince1970)")
            if collision == (PhysicsCategory.Player | PhysicsCategory.Obstacle){
                mainHeroNode.stopMoving()
            } else if collision == (PhysicsCategory.Player | PhysicsCategory.Edges){
                mainHeroNode.stopMoving()
            }
        }
        
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let normal = contact.contactNormal
       
        if collision == PhysicsCategory.Player | PhysicsCategory.Obstacle {
//            print("end coll, normal: \(normal), \(contact.bodyA.node?.name), \(contact.bodyB.node?.name)")
            if normal.dy < 0 {
                mainHeroNode.fall()
            } else {
                mainHeroNode.acceptCompenstionVelosity(compenstionVelocity: normal)
            }
            
        }
    }
}

#Preview {
    StartView()
}
