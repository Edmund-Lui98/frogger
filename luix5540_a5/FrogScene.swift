//
//  FrogScene.swift
//  luix5540_a5
//
//  Created by Prism Student on 2020-03-17.
//  Copyright © 2020 Edmund Lui. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class FrogScene: SKScene,  SKPhysicsContactDelegate {
    var frog = SKSpriteNode()
    
    var left = SKSpriteNode()
    var right = SKSpriteNode()
    var up = SKSpriteNode()
    var down = SKSpriteNode()
    
    var start = SKSpriteNode()
    var finish = SKSpriteNode()
    
    struct PhysicsCategories {
        static let None : UInt32 = 0 //0
        static let frog : UInt32 = 0b1 //1
        static let car : UInt32 = 0b100 //2
    }
        
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        /* Setup your scene here */
        self.backgroundColor = UIColor.white
        
        finish = SKSpriteNode(imageNamed: "rect")
        finish.name = "finishLine"
        finish.size = CGSize(width: self.frame.width, height: 200)
        finish.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 25)
        self.addChild(finish)
        
        start = SKSpriteNode(imageNamed: "rect")
        start.name = "startLine"
        start.size = CGSize(width: self.frame.width, height: 200)
        start.position = CGPoint(x: self.frame.width/2, y: finish.position.y-750)
        self.addChild(start)
        
        left = SKSpriteNode(imageNamed: "left")
        left.name = "leftButton"
        left.size = CGSize(width: 300, height: 200)
        left.position = CGPoint(x: left.frame.width/2, y: left.frame.height/2)
        self.addChild(left)

        right = SKSpriteNode(imageNamed: "right")
        right.name = "rightButton"
        right.size = CGSize(width: 300, height: 200)
        right.position = CGPoint(x: self.frame.width-right.frame.width/2, y: right.frame.height/2)
        self.addChild(right)

        frog = SKSpriteNode(imageNamed: "frog")
        frog.size = CGSize(width: 150, height: 100)
        frog.position = CGPoint(x: self.frame.width/2, y: frog.frame.height/2+right.frame.height)
        frog.physicsBody = SKPhysicsBody(rectangleOf: frog.size)
        frog.physicsBody!.affectedByGravity = false
        frog.physicsBody!.categoryBitMask = PhysicsCategories.frog
        self.addChild(frog)

        up = SKSpriteNode(imageNamed: "up")
        up.name = "upButton"
        up.size = CGSize(width: 300, height: 200)
        up.position = CGPoint(x: self.frame.width-right.frame.width*2, y: right.frame.height/2)
        self.addChild(up)

        down = SKSpriteNode(imageNamed: "down")
        down.name = "downButton"
        down.size = CGSize(width: 300, height: 200)
        down.position = CGPoint(x: left.frame.width*2, y: left.frame.height/2)
        self.addChild(down)
        
        gameStart()
    }
    
    func gameStart() {
        
        let spawn1 = SKAction.run(drawCar1)
        let spawn2 = SKAction.run(drawCar2)
        let spawn3 = SKAction.run(drawCar3)
        let spawn4 = SKAction.run(drawCar4)
        let waitToSpawn1 = SKAction.wait(forDuration: 2)
        let waitToSpawn2 = SKAction.wait(forDuration:6)
        let runCarSound = SKAction.playSoundFileNamed("carSound.mp3", waitForCompletion: false)
        let spawnSequence = SKAction.sequence([runCarSound,spawn1,runCarSound, spawn2,waitToSpawn1, runCarSound,spawn3, waitToSpawn1, runCarSound,spawn4, runCarSound,spawn2,waitToSpawn2])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        
        self.run(spawnForever)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.frog && body2.categoryBitMask == PhysicsCategories.car {
            spawnDead(spawnPosition: body1.node!.position)
            body1.node?.removeFromParent()
            
            let loseScene = LoseScene(size: self.size)
            let transition = SKTransition.doorway(withDuration: 1.0)
            self.view?.presentScene(loseScene, transition: transition)
        }
    } //didBeginContact
    
    func spawnDead(spawnPosition: CGPoint) {
        let dead = SKSpriteNode(imageNamed: "dead")
        dead.size = CGSize(width: frog.size.width, height: frog.size.height)
        dead.position = spawnPosition
        self.addChild(dead)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == right.name {
                print("right button pressed")
                if frog.position.x < self.frame.width-frog.size.width/2 {
                    frog.position = CGPoint(x: frog.position.x + 100, y: frog.position.y)
                }
            } else if theNode.name == left.name {
                print("left button pressed")
                if frog.position.x > frog.size.width/2 {
                    frog.position = CGPoint(x: frog.position.x - 100, y: frog.position.y)
                }
            } else if theNode.name == up.name {
                print("up button pressed")
                print(frog.position.y)
                print(finish.position.y)
                if frog.position.y <= 1000 {
                    frog.position = CGPoint(x: frog.position.x, y: frog.position.y + 50)
                    if frog.position.y > 1000 {
                        //transition to "you win"
                        print("win")
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                        let winScene = WinScene(size: self.size)
                        self.view?.presentScene(winScene, transition: reveal)
                    }
                }
            } else if theNode.name == down.name {
                print("down button pressed")
                if frog.position.y > up.frame.width {
                    frog.position = CGPoint(x: frog.position.x, y: frog.position.y - 50)
                }
            }
        }
    }
    
    func drawCar1() {
        let car = SKSpriteNode(imageNamed: "car1")
        car.size = CGSize(width: 400, height: 200)
        car.position = CGPoint(x: car.frame.width/2-car.frame.width, y: finish.position.y-car.size.height+25)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.affectedByGravity = false
        car.physicsBody!.categoryBitMask = PhysicsCategories.car
        car.physicsBody!.collisionBitMask = PhysicsCategories.None
        car.physicsBody!.contactTestBitMask = PhysicsCategories.frog
        self.addChild(car)
        
        let moveCar = SKAction.moveTo(x: self.frame.width+car.size.width/2, duration: 10)
        let carSequence = SKAction.sequence([moveCar])
        car.run(carSequence)
    }
    func drawCar2() {
        let car = SKSpriteNode(imageNamed: "car2")
        car.size = CGSize(width: 200, height: 100)
        car.position = CGPoint(x: self.frame.width + car.size.width/2, y: finish.position.y-car.size.height*3)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.affectedByGravity = false
        car.physicsBody!.categoryBitMask = PhysicsCategories.car
        car.physicsBody!.collisionBitMask = PhysicsCategories.None
        car.physicsBody!.contactTestBitMask = PhysicsCategories.frog
        self.addChild(car)
        
        let moveCar = SKAction.moveTo(x: -self.frame.width, duration: 10)
        let carSequence = SKAction.sequence([moveCar])
        car.run(carSequence)
    }
    func drawCar3() {
        let car = SKSpriteNode(imageNamed: "car1")
        car.size = CGSize(width: 400, height: 200)
        car.position = CGPoint(x: car.frame.width/2-car.frame.width, y: finish.position.y-car.size.height*2-25)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.affectedByGravity = false
        car.physicsBody!.categoryBitMask = PhysicsCategories.car
        car.physicsBody!.collisionBitMask = PhysicsCategories.None
        car.physicsBody!.contactTestBitMask = PhysicsCategories.frog
        self.addChild(car)
        
        let moveCar = SKAction.moveTo(x: self.frame.width+car.size.width/2, duration: 10)
        let carSequence = SKAction.sequence([moveCar])
        car.run(carSequence)
    }
    func drawCar4() {
        let car = SKSpriteNode(imageNamed: "car2")
        car.size = CGSize(width: 200, height: 100)
        car.position = CGPoint(x: self.frame.width + car.size.width/2, y: finish.position.y-car.size.height*6+25)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.affectedByGravity = false
        car.physicsBody!.categoryBitMask = PhysicsCategories.car
        car.physicsBody!.collisionBitMask = PhysicsCategories.None
        car.physicsBody!.contactTestBitMask = PhysicsCategories.frog
        self.addChild(car)
        
        
        let moveCar = SKAction.moveTo(x: -self.frame.width, duration: 10)
        let carSequence = SKAction.sequence([moveCar])
        car.run(carSequence)
    }

}
