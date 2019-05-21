//
//  LockView.swift
//  animasé
//
//  Created by William Inx on 20/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class LockView{
    // Init objects for lockView
    var lockView :UIView!
    var leftLockView :UIView!
    var rightLockView :UIView!
    var startButton :UIButton!
    
    init(main :UIViewController) {
        
        initViews(main :main)
        
        addCircleLock(main :main)
        addLeftTriangle(main :main)
        addRightTriangle(main :main)
        addStartButton(main :main)
        
        lockView.addSubview(leftLockView)
        lockView.addSubview(rightLockView)
        lockView.addSubview(startButton)
    }
    
    fileprivate func initViews(main :UIViewController) {
        // Init views
        lockView = UIView(frame: CGRect(x: 0, y: 0, width: main.view.frame.maxX, height: main.view.frame.maxY))
        
        lockView.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 64/255, alpha: 1)
        
        leftLockView = UIView(frame: CGRect(x: 0, y: 0, width: main.view.frame.maxX/2, height: main.view.frame.maxY))
        rightLockView = UIView(frame: CGRect(x: main.view.frame.maxX/2, y: 0, width: main.view.frame.maxX/2, height: main.view.frame.maxY))
    }
    
    fileprivate func addCircleLock(main :UIViewController) {
        let circleLockPath = UIBezierPath(arcCenter: CGPoint(x: main.view.frame.maxX/2, y: main.view.frame.maxY/2), radius: main.view.frame.maxX/8, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circleLock = CAShapeLayer()
        circleLock.path = circleLockPath.cgPath
        leftLockView.layer.addSublayer(circleLock)
        
    }
    
    fileprivate func addLeftTriangle(main :UIViewController) {
        let leftTrianglePath = UIBezierPath()
        leftTrianglePath.move(to: .zero)
        leftTrianglePath.addLine(to: CGPoint(x: main.view.frame.maxX/2, y: main.view.frame.maxY/2))
        leftTrianglePath.addLine(to: CGPoint(x: 0, y: main.view.frame.maxY))
        leftTrianglePath.addLine(to: .zero)
        
        let leftTriangle = CAShapeLayer()
        
        leftTriangle.path = leftTrianglePath.cgPath
        leftLockView.layer.addSublayer(leftTriangle)
    }
    
    fileprivate func addRightTriangle(main :UIViewController) {
        let rightTrianglePath = UIBezierPath()
        rightTrianglePath.move(to: CGPoint(x: main.view.frame.maxX/2, y: 0))
        rightTrianglePath.addLine(to: CGPoint(x: 0, y: main.view.frame.maxY/2))
        rightTrianglePath.addLine(to: CGPoint(x: main.view.frame.maxX/2, y: main.view.frame.maxY))
        rightTrianglePath.addLine(to: CGPoint(x: main.view.frame.maxX/2, y: 0))
        
        let rightTriangle = CAShapeLayer()
        
        rightTriangle.path = rightTrianglePath.cgPath
        rightLockView.layer.addSublayer(rightTriangle)
    }
    
    fileprivate func addStartButton(main :UIViewController) {
        startButton = UIButton(type: .system)
        startButton.setTitle("▶️", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        startButton.addTarget(self, action: #selector(startApp), for: .touchDown)
        startButton.frame = CGRect(x: main.view.frame.maxX/2, y: main.view.frame.maxY/2, width: 100, height: 100)
        
        startButton.layer.position.x -= 50
        startButton.layer.position.y -= 50
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
            soundAudio.addSoundFX(audio: "mainTheme",isRepeat: true)
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
