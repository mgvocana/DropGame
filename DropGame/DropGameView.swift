//
//  DropGameView.swift
//  DropGame
//
//  Created by Vocana, Maya on 11/15/21.
//

import SwiftUI
import SpriteKit

struct DropGameView: View
{
    let height : CGFloat = 300
    let width : CGFloat = 400
    
    private var simpleScene : GameScene
    {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View
    {
        SpriteView(scene: simpleScene)
            .frame(width: width, height: height)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        DropGameView()
    }
}
