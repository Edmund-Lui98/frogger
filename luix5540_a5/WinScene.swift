//
//  WinScene.swift
//  luix5540_a5
//
//  Created by Prism Student on 2020-03-16.
//  Copyright © 2020 Edmund Lui. All rights reserved.
//

import UIKit
import SpriteKit

class WinScene: SKScene {
    
    var backButton : SKSpriteNode?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.darkGray
        label.fontSize = 200
        label.text = "You win"
        label.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
        self.addChild(label)
        
        
        let label2 = SKLabelNode(fontNamed: "Courier")
        label2.fontColor = SKColor.darkGray
        label2.fontSize = 100
        label2.text = "Going back to menu..."
        label2.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(label2)
        
        backButton = SKSpriteNode(imageNamed: "car1.png")
        backButton!.name="backButton"
        backButton!.position = CGPoint(x:self.frame.midX, y:self.frame.midY-100);
        self.addChild(backButton!)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == backButton!.name {
                print("The \(backButton!.name!) is touched ")
                let transition = SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            // println("touch outside")
        }
    } //touchesBegan
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
