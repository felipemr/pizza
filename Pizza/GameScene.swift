//
//  GameScene.swift
//  Pizza
//
//  Created by Felipe Ramos on 2/9/16.
//  Copyright (c) 2016 Felipe Ramos. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var bg1 = SKSpriteNode(imageNamed: "back")
    var bg2 = SKSpriteNode(imageNamed: "back")
    var player = SKSpriteNode(imageNamed: "player")
    
    var score = 0.0

    override func didMoveToView(view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
        //Right
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        view.addGestureRecognizer(swipeRight)
        //Left
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)

        
        
        setUpBg()
        setUpPlayer()
        
        let spawnRandomFatMen = SKAction.runBlock(spawnEnemy)
        let waitTime = SKAction.waitForDuration(1.0)
        let sequence = SKAction.sequence([spawnRandomFatMen,waitTime])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
    //MARK:- game initialisation
    func setUpBg(){
        bg1.position = CGPointMake( self.size.width/2, 0)
        bg2.position = CGPointMake(self.size.width/2, bg1.size.height-1)

        self.addChild(bg1)
        self.addChild(bg2)
    }
    func setUpPlayer(){
        player.anchorPoint = CGPointZero
        player.size = CGSize(width: 50, height: 50)
        player.position.x = self.view!.center.x - player.frame.width/2
        player.position.y = self.view!.center.y - 200
        player.zPosition = 1000
        self.addChild(player)
    }
    func spawnEnemy(){
        let fatMan = SKSpriteNode(imageNamed: "fatMan")
        fatMan.size = CGSize(width: 50, height: 50)
        fatMan.zPosition = 90
        fatMan.position = CGPoint(x: frame.size.width * randomNumber(min: 0, max: 1), y: frame.size.height + fatMan.size.height)
        
        fatMan.physicsBody = SKPhysicsBody(circleOfRadius: fatMan.frame.size.width * 0.3)

        self.addChild(fatMan)

    }
    
    //MARK:- handle inputs
    func swiped(sender:UISwipeGestureRecognizer){
        //trocar por pan ou descobrir se tem como controlar o qnt é o swipe
        if sender.direction == .Left{
            goLeft()
        }
        
        if sender.direction == .Right{
            goRight()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let localX  = touches.first!.locationInView(self.view).x
        
        if localX > self.view?.center.x {
            goRight()
        }
        else{
            goLeft()
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.removeActionForKey("movimento")
    }
    
    //MARK:- Moviment
    func goRight(){
        var move = SKAction()
        var rotate = SKAction()
        
        move = SKAction.moveToX((self.view?.frame.width)! - player.size.width, duration: 1)
        rotate = SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 0.5)
        
        player.runAction(SKAction.group([move,rotate]), withKey: "movimento")
    }
    func goLeft(){
        var move = SKAction()
        var rotate = SKAction()
        
        move = SKAction.moveToX(0 + player.size.width, duration: 1)
        rotate = SKAction.rotateByAngle(CGFloat(M_PI_2) * -1, duration: 0.5)
        
        player.runAction(SKAction.group([move,rotate]), withKey: "movimento")
    }
    
    //MARK:- Update
    var speedy: CGFloat = 10
    var lastTime = 0.0
    var timer = 0.0
    var firstTime = true
    override func update(currentTime: CFTimeInterval) {
        moveBG()
        clocky(currentTime)
    }
    
    func moveBG(){
        bg1.position = CGPointMake(bg1.position.x, bg1.position.y-speedy);
        bg2.position = CGPointMake(bg2.position.x, bg2.position.y-speedy);
        
        if (bg1.position.y < -bg1.size.height / 2){
            
            bg1.position = CGPointMake(bg2.position.x, bg2.position.y + bg1.size.height);
            
        }
        
        if (bg2.position.y < -bg2.size.height / 2) {
            
            bg2.position = CGPointMake(bg1.position.x, bg1.position.y + bg2.size.height);
            
        }
    }
    
    func clocky(currentTime: CFTimeInterval){
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
    
    //MARK:- Utils
    func randomNumber(min min: CGFloat, max: CGFloat) -> CGFloat {
        let random = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        return random * (max - min) + min
    }
}
