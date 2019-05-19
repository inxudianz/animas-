//
//  Face.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class Face{
    
    // Init Head
    var headPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 25), radius: CGFloat(40), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    var head = CAShapeLayer()
    var eyePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(10), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    var lEye = CAShapeLayer()
    
    var rEye = CAShapeLayer()
    
    var mouthPathHappy = UIBezierPath(arcCenter: CGPoint(x: 30, y: 0), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi), clockwise: true)
    var mouthPathSad = UIBezierPath(arcCenter: CGPoint(x: 30, y: 0), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi), clockwise: false)
    var mouthPathNeutral = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 40, height: 15), cornerRadius: 5)
    var mouth = CAShapeLayer()
    
    init() {
        head.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        head.path = headPath.cgPath
        
        lEye.fillColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lEye.path = eyePath.cgPath
        
        rEye.fillColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        rEye.path = eyePath.cgPath
        
        mouth.path = mouthPathNeutral.cgPath
        mouth.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        lookRight()
    }
    
    func lookRight() {
        lEye.position.x = 50
        rEye.position.x = 80
        mouth.position.x = 40
    }
    
    func lookLeft() {
        lEye.position.x = 20
        rEye.position.x = 50
        mouth.position.x = 20
    }
    
    func beSad() {
        mouth.path = mouthPathSad.cgPath
    }
    
    func beHappy() {
        mouth.path = mouthPathHappy.cgPath
    }
}
