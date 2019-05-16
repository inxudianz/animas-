//
//  MainViewViewController.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {
    
    // Init objects
    var lockView :UIView!
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
        
     //   landView.addSubview(<#T##view: UIView##UIView#>)
     //   landView.addSubview(<#T##view: UIView##UIView#>)

        
        // Do any additional setup after loading the view.
    }

    func initLockView() {
        lockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        
        lockView.backgroundColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        
        let circlePath1 = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2), radius: self.view.frame.maxX, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2), radius: self.view.frame.maxX/2, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circlePath3 = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2), radius: self.view.frame.maxX/3, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circlePath4 = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2), radius: self.view.frame.maxX/4, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let circle1 = CAShapeLayer()
        let circle2 = CAShapeLayer()
        let circle3 = CAShapeLayer()
        let circle4 = CAShapeLayer()

        circle1.path = circlePath1.cgPath
        circle1.fillColor = UIColor(red: 100/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        circle2.path = circlePath2.cgPath
        circle2.fillColor = UIColor(red: 125/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        circle3.path = circlePath3.cgPath
        circle3.fillColor = UIColor(red: 150/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        circle4.path = circlePath4.cgPath
        circle4.fillColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
        
        let startButton = UIButton(type: .system)
        
        startButton.layer.cornerRadius = 500
        startButton.layer.backgroundColor = UIColor(red: 220/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        startButton.setTitle("Open", for: .normal)
        startButton.addTarget(self, action: #selector(startApp), for: .touchDown)
        startButton.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 50, height: 100)
        
        lockView.layer.addSublayer(circle1)
        lockView.layer.addSublayer(circle2)
        lockView.layer.addSublayer(circle3)
        lockView.layer.addSublayer(circle4)
        lockView.addSubview(startButton)
    }
    
    @objc func startApp() {
        UIView.animate(withDuration: 1) {
            self.lockView.isHidden = true
        }
    }
    
    func animHead() {
        UIView.animate(withDuration: 3) {
            self.boyFace.head.position = CGPoint(x: 20, y: 20)
        }
        
        }
    
}

