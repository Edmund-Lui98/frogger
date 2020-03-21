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
    
    var frog : SKSpriteNode?
    var playButton : SKLabelNode?
    let backgroundMusic = SKAudioNode(fileNamed: "inGame.wav")

    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        
        frog = SKSpriteNode(imageNamed: "frog")
        frog!.size = CGSize(width: 300, height:300)
        frog!.position = CGPoint(x:self.frame.midX, y:self.frame.midY+300);
        self.addChild(frog!)
        
        let playButton = SKLabelNode(fontNamed: "Courier")
        playButton.fontColor = SKColor.darkGray
        playButton.fontSize = 200
        playButton.name="playButton"
        playButton.text = "PLAY"
        playButton.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(playButton)
        
        let playMusic = SKLabelNode(fontNamed: "Courier")
        playMusic.fontColor = SKColor.darkGray
        playMusic.fontSize = 100
        playMusic.name="playMusic"
        playMusic.text = "Play music"
        playMusic.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-300);
        self.addChild(playMusic)
        
        let stopMusic = SKLabelNode(fontNamed: "Courier")
        stopMusic.fontColor = SKColor.darkGray
        stopMusic.fontSize = 100
        stopMusic.name="stopMusic"
        stopMusic.text = "Stop music"
        stopMusic.position =  CGPoint(x:self.frame.midX, y: playMusic.position.y-100);
        self.addChild(stopMusic)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == "playButton" {
                print("play button pressed")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
                let frogScene = FrogScene(size: self.size)
                self.view?.presentScene(frogScene, transition: transition)
            } else if theNode.name == "playMusic" {
                print("play music button pressed")
                backgroundMusic.autoplayLooped = true
                addChild(backgroundMusic)
                //run(SKAction.playSoundFileNamed("inGame.wav", waitForCompletion: false), withKey: "backgroundMusic")
                
                //run(SKAction.playSoundFileNamed("inGame.wav", waitForCompletion: false))
            } else if theNode.name == "stopMusic" {
                print("stop music button pressed")
                backgroundMusic.removeFromParent()
                
            }
        }
    }
}
