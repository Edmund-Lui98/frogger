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
        
        returnHome()
    
    }
    func returnHome() {
        
        let home = SKAction.run() {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
        }
        let delay = SKAction.wait(forDuration: 3)
        let ret = SKAction.sequence([delay,home])
        self.run(ret)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
