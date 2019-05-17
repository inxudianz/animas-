//
//  MainViewViewController.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {
    
    // Init objects for firstView
    var lockView :UIView!
    var leftLockView :UIView!
    var rightLockView :UIView!
    var startButton :UIButton!
    
    // Init objects for secondary view
    var landView :UIView!
    var controlLeft :UIButton!
    var controlRight :UIButton!
    var controlAction :UIButton!
    
    var skyView :UIView!
    
    var faceView :UIView!
    var boyFace :Face!
    
    var arrowView :UIView!
    var leftArrow :Arrow!
    var leftButton :UIButton!
    var rightButton :UIButton!
    var rightArrow :Arrow!
    var actionButton :UIButton!
    
    var chestView :UIView!
    var chest :Chest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLockView()
        // Init landView
        landView = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - (self.view.frame.maxY / 3), width: self.view.frame.maxX, height: self.view.frame.maxY / 3))
        landView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        // Init skyView
        skyView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        skyView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        // Init faceView
        faceView = UIView(frame: CGRect(x: self.view.frame.maxX / 3, y: (skyView.frame.maxY / 2) + 60, width: 100, height: 100))
        boyFace = Face()
        boyFace.head.position.x += 50
        boyFace.head.position.y += 20
        boyFace.lEye.position.x += 50
        boyFace.lEye.position.y += 20
        boyFace.rEye.position.x += 50
        boyFace.rEye.position.y += 20
        boyFace.mouth.position.x += 50
        boyFace.mouth.position.y += 20
        
        faceView.backgroundColor = .black
        // Buttons view
        arrowView = UIView(frame: CGRect(x: landView.frame.minX + 5, y: landView.frame.minY + 5, width: landView.frame.maxX - 10, height: landView.frame.maxY - 10))
        leftArrow = Arrow(isReversed: true)
        rightArrow = Arrow(isReversed: false)
        
        leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x:  20, y: 80, width: 100, height: 100)
        leftArrow.arrowHead.position.x += 40
        leftArrow.stick.position.x += 40
        leftButton.layer.addSublayer(leftArrow.arrowHead)
        leftButton.layer.addSublayer(leftArrow.stick)
        leftButton.accessibilityIdentifier = "left"
        leftButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        rightButton = UIButton(type: .system)
        rightButton.frame = CGRect(x: 120, y: 80, width: 100, height: 100)
        rightArrow.arrowHead.position.x += 20
        rightArrow.stick.position.x += 20
        rightButton.layer.addSublayer(rightArrow.arrowHead)
        rightButton.layer.addSublayer(rightArrow.stick)
        rightButton.accessibilityIdentifier = "right"
        rightButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = .black
        actionButton.frame = CGRect(x: 270, y: 80, width: 70, height: 70)
        actionButton.layer.cornerRadius = 38
        actionButton.setTitle("A", for: .normal)
        actionButton.titleLabel?.font = UIFont(name: "Arial", size: CGFloat(40))
        actionButton.accessibilityIdentifier = "action"
        actionButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        arrowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        chest = Chest()
        chest.chest.position.x += 10
        chest.chest.position.y += 65
        chest.chestLid.position.x += 10
        chest.chestLid.position.y += 65
        chest.chestLock.position.x += 10
        chest.chestLock.position.y += 65
        
        chestView = UIView(frame: CGRect(x: skyView.frame.maxX - 100, y: skyView.frame.maxY - 400, width: 100, height: 100))
        chestView.backgroundColor = .blue
        chestView.layer.addSublayer(chest.chestLid)

        chestView.layer.addSublayer(chest.chest)
        chestView.layer.addSublayer(chest.chestLock)
        
        // add views to main viewcontroller
        self.view.addSubview(skyView)
        self.view.addSubview(landView)
        self.view.addSubview(faceView)
        self.view.addSubview(arrowView)
        self.view.addSubview(chestView)
        faceView.layer.addSublayer(boyFace.head)
        faceView.layer.addSublayer(boyFace.lEye)
        faceView.layer.addSublayer(boyFace.rEye)
        faceView.layer.addSublayer(boyFace.mouth)
        
        arrowView.addSubview(leftButton)
        arrowView.addSubview(rightButton)
        arrowView.addSubview(actionButton)
        
        self.view.addSubview(lockView)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pressControl(sender: UIButton!) {
        if sender.accessibilityIdentifier == "left" {
            faceView.layer.position.x -= 10
        }
        else if sender.accessibilityIdentifier == "right" {
            faceView.layer.position.x += 10
        }
        else if sender.accessibilityIdentifier == "action" {
            // detect collision!
            if faceView.frame.intersects(chestView.frame) {
                chestView.layer.opacity = 0
                chestView.layer.position = CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2)
                
                UIView.animate(withDuration: 1) {
                    self.chestView.layer.opacity = 1
                }
            }
        }
    }

    func initLockView() {
        lockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        
        lockView.backgroundColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        
        leftLockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX/2, height: self.view.frame.maxY))
        rightLockView = UIView(frame: CGRect(x: self.view.frame.maxX/2, y: 0, width: self.view.frame.maxX/2, height: self.view.frame.maxY))
        
        let circleLockPath = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2 + 20, y: self.view.frame.maxY/2), radius: self.view.frame.maxX/8, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let leftTrianglePath = UIBezierPath()
        leftTrianglePath.move(to: .zero)
        leftTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2))
        leftTrianglePath.addLine(to: CGPoint(x: 0, y: self.view.frame.maxY))
        leftTrianglePath.addLine(to: .zero)
        
        let rightTrianglePath = UIBezierPath()
        rightTrianglePath.move(to: CGPoint(x: self.view.frame.maxX/2, y: 0))
        rightTrianglePath.addLine(to: CGPoint(x: 0, y: self.view.frame.maxY/2))
        rightTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY))
        rightTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX/2, y: 0))
        
        let circleLock = CAShapeLayer()
        let leftTriangle = CAShapeLayer()
        let rightTriangle = CAShapeLayer()
        rightTriangle.position.x -= 5

        circleLock.path = circleLockPath.cgPath
        leftTriangle.path = leftTrianglePath.cgPath
        rightTriangle.path = rightTrianglePath.cgPath
        
        startButton = UIButton(type: .system)
        
        startButton.layer.cornerRadius = 500
        startButton.layer.backgroundColor = UIColor(red: 220/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        startButton.setTitle("Open", for: .normal)
        startButton.addTarget(self, action: #selector(startApp), for: .touchDown)
        startButton.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 50, height: 100)
        
        
        lockView.addSubview(leftLockView)
        leftLockView.layer.addSublayer(leftTriangle)
        leftLockView.layer.addSublayer(circleLock)
        
        lockView.addSubview(rightLockView)
        rightLockView.layer.addSublayer(rightTriangle)
        
        lockView.addSubview(startButton)
    }
    
    @objc func startApp() {
        startButton.isHidden = true
        if let layers = leftLockView.layer.sublayers {
            for layer in layers.reversed() {
                UIView.animate(withDuration: 50) {
                    layer.transform = CATransform3DScale(layer.transform, CGFloat(0.1), CGFloat(5), CGFloat(1))
                }
                break
            }
        }
        
        if let layers = leftLockView.layer.sublayers {
            for layer in layers {
                UIView.animate(withDuration: 50) {
                    layer.position.x -= 500
                }
                break
            }
        }
        
        if let layers = rightLockView.layer.sublayers {
            for layer in layers {
                UIView.animate(withDuration: 50) {
                    layer.position.x += 500
                }
                break
            }
        }
        
        UIView.animate(withDuration: 1) {
            self.lockView.layer.opacity = 0
            self.startButton.layer.position.y += 1000
        }
        
    }
    
    
}

