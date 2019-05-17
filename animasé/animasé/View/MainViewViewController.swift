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
    var arrow :Arrow!
    
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
        faceView = UIView(frame: CGRect(x: self.view.frame.maxX / 3, y: (skyView.frame.maxY / 2), width: self.view.frame.maxX / 3, height: self.view.frame.maxY / 5))
        boyFace = Face()
        
        arrowView = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        arrow = Arrow(isReversed: true)
        
        
        
        // add views to main viewcontroller
        self.view.addSubview(skyView)
        self.view.addSubview(landView)
        self.view.addSubview(faceView)
        self.view.addSubview(arrowView)
        faceView.layer.addSublayer(boyFace.head)
        faceView.layer.addSublayer(boyFace.lEye)
        faceView.layer.addSublayer(boyFace.rEye)
        faceView.layer.addSublayer(boyFace.mouth)
        arrowView.layer.addSublayer(arrow.arrowHead)
        arrowView.layer.addSublayer(arrow.stick)
        
        self.view.addSubview(lockView)
        
        // Do any additional setup after loading the view.
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
    
    func animHead() {
        UIView.animate(withDuration: 3) {
            self.boyFace.head.position = CGPoint(x: 20, y: 20)
        }
        
        }
    
}

