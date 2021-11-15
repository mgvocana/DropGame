//
//  GameScene.swift
//  DropGame
//
//  Created by Vocana, Maya on 11/15/21.
//

import SpriteKit

class GameScene : SKScene
{
    override func didMove(to view : SKView)
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event : UIEvent?)
    {
        guard let touch = touches.first
        else {return}
        let currentColor = assignColorAndBitmask()
        let width = Int(arc4random() % 50)
        let height = Int(arc4random() % 50)
        let location = touch.location(in: self)
        let node : SKSpriteNode
        node = SKSpriteNode(color: currentColor, size: CGSize(width: width, height: height))
        node.position = location
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        
        addChild(node)
    }
    
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.cyan, .purple, .green, .magenta, .blue, .yellow]
        let randomIndex = Int(arc4random()) % colors.count
        
        return colors[randomIndex]
    }
}
