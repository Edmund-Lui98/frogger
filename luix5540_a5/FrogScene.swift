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

class FrogScene: SKScene {
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
        frog.size = CGSize(width: 300, height: 200)
        frog.position = CGPoint(x: self.frame.width/2, y: frog.frame.width/2+right.frame.height)
        self.addChild(frog)

        up = SKSpriteNode(imageNamed: "up")
        up.name = "upButton"
        up.size = CGSize(width: 300, height: 200)
        up.position = CGPoint(x: self.frame.width-right.frame.width*3, y: right.frame.width/2)
        self.addChild(up)

        down = SKSpriteNode(imageNamed: "down")
        down.name = "downButton"
        down.size = CGSize(width: 300, height: 200)
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
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                        let winScene = WinScene(size: self.size)
                        self.view?.presentScene(winScene, transition: reveal)
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
