//
//  GameScene.swift
//  luix5540_a5
//
//  Created by Prism Student on 2020-03-12.
//  Copyright © 2020 Edmund Lui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//
//    override func didMove(to view: SKView) {
//
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
//    }
//
//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }    
    var frog = SKSpriteNode()
    
    var left = SKSpriteNode()
    var right = SKSpriteNode()
    var up = SKSpriteNode()
    var down = SKSpriteNode()
    
    var start = SKSpriteNode()
    var finish = SKSpriteNode()
        
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.white
        
        finish = SKSpriteNode(imageNamed: "rect")
        finish.name = "finishLine"
        finish.size = CGSize(width: 2000, height: 200)
        finish.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(finish)
        
        start = SKSpriteNode(imageNamed: "rect")
        start.name = "startLine"
        start.size = CGSize(width: 2000, height: 200)
        start.position = CGPoint(x: self.frame.width/2, y: finish.position.y-725)
        self.addChild(start)
        
        left = SKSpriteNode(imageNamed: "left")
        left.name = "leftButton"
        left.size = CGSize(width: 200, height: 200)
        left.position = CGPoint(x: left.frame.width*2, y: left.frame.width/2)
        self.addChild(left)

        right = SKSpriteNode(imageNamed: "right")
        right.name = "rightButton"
        right.size = CGSize(width: 200, height: 200)
        right.position = CGPoint(x: self.frame.width-right.frame.width*2, y: right.frame.width/2)
        self.addChild(right)

        frog = SKSpriteNode(imageNamed: "frog")
        frog.size = CGSize(width: 200, height: 200)
        frog.position = CGPoint(x: self.frame.width/2, y: frog.frame.width/2+right.frame.width)
        self.addChild(frog)

        up = SKSpriteNode(imageNamed: "up")
        up.name = "upButton"
        up.size = CGSize(width: 200, height: 200)
        up.position = CGPoint(x: self.frame.width-right.frame.width*3, y: right.frame.width/2)
        self.addChild(up)

        down = SKSpriteNode(imageNamed: "down")
        down.name = "downButton"
        down.size = CGSize(width: 200, height: 200)
        down.position = CGPoint(x: left.frame.width*3, y: left.frame.width/2)
        self.addChild(down)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == right.name {
                print("right button pressed")
                frog.position = CGPoint(x: frog.position.x + 50, y: frog.position.y)
            } else if theNode.name == left.name {
                print("left button pressed")
                frog.position = CGPoint(x: frog.position.x - 50, y: frog.position.y)
            } else if theNode.name == up.name {
                print("up button pressed")
                print(frog.position.y)
                print(finish.position.y)
                if frog.position.y <= 1000 {
                    frog.position = CGPoint(x: frog.position.x, y: frog.position.y + 50)
                    if frog.position.y > 1000 {
                        //transition to "you win"
                        print("win")
                        
                    }
                }
            } else if theNode.name == down.name {
                print("down button pressed")
                if frog.position.y > up.frame.width*1.5 {
                    frog.position = CGPoint(x: frog.position.x, y: frog.position.y - 50)
                }  else if frog.position.y == finish.position.y {
                    //transition to "you win"
                    print("win")
                }
                
            }
        }
    }
}
