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
        
        let endNode = SKLabelNode(fontNamed: "Charter-Black")
        endNode.fontSize = 20
        endNode.fontColor = .black
        endNode.zPosition = 2
        endNode.position.x = frame.midX
        endNode.position.y = frame.midY + 10
        endNode.text = "Game Over!"
        
        let restartNode = SKLabelNode(fontNamed: "Charter-Black")
        restartNode.fontSize = 20
        restartNode.fontColor = .black
        restartNode.zPosition = 2
        restartNode.position.x = frame.midX
        restartNode.position.y = frame.midY - 10
        restartNode.text = "Pinch to restart"
        
        addChild(scoreNode)
        addChild(endNode)
        addChild(restartNode)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.view?.addGestureRecognizer(pinchRecognizer)
    }
    
    private func restart() -> Void
    {
        let transition = SKTransition.fade(with: .magenta, duration: 15)
        let restartScene = GameScene()
        restartScene.size = CGSize(width: 300, height: 400)
        restartScene.scaleMode = .fill
        self.view?.presentScene(restartScene, transition: transition)
    }
    
    @objc
    private func handlePinch(recognizer: UIPinchGestureRecognizer) -> Void
    {
        if recognizer.state == .ended
        {
            restart()
        }
    }
}
