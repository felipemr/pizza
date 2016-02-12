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
//    var player1 = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    var player = SKSpriteNode(imageNamed: "Spaceship")
    var fatMan = SKSpriteNode(imageNamed: "fatMan")
    override func didMoveToView(view: SKView) {

        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)

        setUpBg()
        
        setUpPlayer()
        
//        setUpEnemy()

    }
    
    func setUpBg(){
        myFloor1 = SKSpriteNode(imageNamed: "back")
        myFloor1.position = CGPointMake( self.size.width/2, 0)
        
        myFloor2 = SKSpriteNode(imageNamed: "back")
        myFloor2.position = CGPointMake(self.size.width/2, myFloor1.size.height-1)
        
        
        self.addChild(myFloor1)
        self.addChild(myFloor2)
    }
    func setUpPlayer(){
        player.anchorPoint = CGPointZero
        player.size = CGSize(width: 50, height: 50)
        player.position.x = self.view!.center.x - player.frame.width/2
        player.position.y = self.view!.center.y - 200
        player.zPosition = 1000
        self.addChild(player)
    }
    func setUpEnemy(){
        fatMan.position = CGPoint(x: self.size.width/2 + 35, y: 3*(self.size.height/4))
        fatMan.size = CGSize(width: 50, height: 50)
        fatMan.zPosition = 90
        self.addChild(fatMan)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
    var speedy: CGFloat = 10
    var lastTime = 0.0
    var timer = 0.0
    var firstTime = true
    
    
    
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
        
        if firstTime {
            firstTime = false
            lastTime = currentTime
        }else{
            let delta = currentTime - lastTime
            lastTime = currentTime
        
            if timer > 10 {
                speedy++
                timer = 0
            }
            else{
                timer += delta
            }
        }
        
    }
    
    func swiped(sender:UISwipeGestureRecognizer){
        if sender.direction == .Left{
            print("left")
            player.position.x -= speedy
        }
        
        if sender.direction == .Right{
            print("right")
            player.position.x += speedy
        }
    }
}
