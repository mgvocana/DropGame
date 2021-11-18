//
//  EndGameScene.swift
//  DropGame
//
//  Created by Vocana, Maya on 11/18/21.
//

import SpriteKit

class EndGameScene : SKScene
{
    var score : Int = 0
    
    override func didMove(to view: SKView) -> Void
    {
        backgroundColor = UIColor.purple
        
        let scoreNode = SKLabelNode(fontNamed: "Charter-Black")
        scoreNode.fontSize =  20
        scoreNode.fontColor = .black
        scoreNode.zPosition = 2
        scoreNode.position.x = frame.midX
        scoreNode.position.y = frame.midY + 30
        scoreNode.text = "Score: \(score)"
    }
}
