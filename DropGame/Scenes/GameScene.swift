//
//  GameScene.swift
//  DropGame
//
//  Created by Vocana, Maya on 11/15/21.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate
{
    //MARK: Data members
    private var colorMask : Int = 0b0000
    
    private var score : Int = -0
    {
        didSet
        {
            scoreNode.text = "Current Score: \(score)"
        }
    }
    private let scoreNode : SKLabelNode = SKLabelNode(fontNamed: "Charter-Bold")
    let catTexture = SKTexture(imageNamed: "cat")

    
    //MARK: - SKScene override methods
    override func didMove(to view : SKView)
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        //Add score label
        scoreNode.zPosition = 2
        scoreNode.position.x = 120
        scoreNode.position.y = 385
        scoreNode.fontSize = 20
        addChild(scoreNode)
        score = 0 //Force a call to the didSet observer
        
        //Add Audio
        let backgroundMusic  = SKAudioNode(fileNamed: "Go")
        backgroundMusic.name = "music"
        addChild(backgroundMusic)
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
        node = SKSpriteNode(texture: catTexture, color: currentColor, size: CGSize(width: width, height: height))
        node.colorBlendFactor = 1.0
        node.position = location
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        
        node.physicsBody?.contactTestBitMask = UInt32(colorMask)
        
        addChild(node)
    }
    
    //MARK: - Custom methods
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.cyan, .purple, .magenta, .green]
        let randomIndex = Int(arc4random()) % colors.count
        
        colorMask = randomIndex + 1
        
        return colors[randomIndex]
    }
    
    private func explosionEffect(at location: CGPoint) -> Void
    {
        if let explosion = SKEmitterNode(fileNamed: "SparkParticle")
        {
            explosion.position = location
            addChild(explosion)
            let waitTime = SKAction.wait(forDuration: 5)
            let removeExplosion = SKAction.removeFromParent()
            let explosiveSequence = SKAction.sequence([waitTime, removeExplosion])
            
            let effectSound = SKAction.playSoundFileNamed("drop bass", waitForCompletion: false)
            run(effectSound)
            
            explosion.run(explosiveSequence)
        }
    }
    
    private func updateSound() -> Void
    {
        if let sound = childNode(withName: "music")
        {
            let speedUp = SKAction.changePlaybackRate(by: 1.5, duration: 10)
            sound.run(speedUp)
        }
    }
    
    private func endGame() -> Void
    {
        
    }
    
    //MARK: - Physics handling methods
    private func annihilate(deadNode : SKNode) -> Void
    {
        score += 10
        explosionEffect(at: deadNode.position)
        updateSound()
        deadNode.removeFromParent()
    }
    
    private func collisionBetween(_ nodeOne : SKNode, and nodeTwo : SKNode) -> Void
    {
        if (nodeOne.physicsBody?.contactTestBitMask == nodeTwo.physicsBody?.contactTestBitMask)
        {
            annihilate(deadNode: nodeOne)
            annihilate(deadNode: nodeTwo)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) -> Void
    {
        guard let first = contact.bodyA.node else {return}
        guard let second = contact.bodyB.node else {return}
        
        collisionBetween(first, and: second)
    }
}
