//
//  LoseScene.swift
//  luix5540_a5
//
//  Created by Prism Student on 2020-03-17.
//  Copyright © 2020 Edmund Lui. All rights reserved.
//

import UIKit
import SpriteKit

class LoseScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.darkGray
        label.fontSize = 30
        label.text = "You lose :("
        label.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+100);
        self.addChild(label)
    
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
