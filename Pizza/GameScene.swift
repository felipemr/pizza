//
//  GameScene.swift
//  Pizza
//
//  Created by Felipe Ramos on 2/9/16.
//  Copyright (c) 2016 Felipe Ramos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var myFloor1 = SKSpriteNode()
    var myFloor2 = SKSpriteNode()
    var player = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
    override func didMoveToView(view: SKView) {

        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)

        myFloor1 = SKSpriteNode(imageNamed: "fokd")
        myFloor1.color = UIColor.blueColor()
        myFloor1.colorBlendFactor = 1
        myFloor1.position = CGPointMake( self.size.width/2, 0);
        
        myFloor2 = SKSpriteNode(imageNamed: "fokd")
        myFloor2.colorBlendFactor = 1
        myFloor2.color = UIColor.brownColor()
        myFloor2.position = CGPointMake(self.size.width/2, myFloor1.size.height-1);
        
        
        player.fillColor = UIColor.yellowColor()
        player.position.x = self.view!.center.x - player.frame.width/2
        player.position.y = self.view!.center.y - 200
        player.zPosition = 1000
        
        self.addChild(myFloor1)
        self.addChild(myFloor2)
        self.addChild(player)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
    var speedy: CGFloat = 10
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        myFloor1.position = CGPointMake(myFloor1.position.x, myFloor1.position.y-speedy);
        
        myFloor2.position = CGPointMake(myFloor2.position.x, myFloor2.position.y-speedy);
        
        if (myFloor1.position.y < -myFloor1.size.height / 2){
            
            myFloor1.position = CGPointMake(myFloor2.position.x, myFloor2.position.y + myFloor1.size.height);
            
        }
        
        if (myFloor2.position.y < -myFloor2.size.height / 2) {
            
            myFloor2.position = CGPointMake(myFloor1.position.x, myFloor1.position.y + myFloor2.size.height);
            
        }

    }
    
    func swiped(sender:UISwipeGestureRecognizer){
        if sender.direction == .Left{
            print("left")
            player.position.x -= 10
        }
        
        if sender.direction == .Right{
            print("right")
            player.position.x += 10
        }
    }
}
