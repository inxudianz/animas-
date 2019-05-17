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
    var eyePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CGFloat(6), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    var lEye = CAShapeLayer()
    
    var rEye = CAShapeLayer()
    
    var mouthPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 25), radius: CGFloat(14), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi), clockwise: true)
    var mouth = CAShapeLayer()
    
    init() {
        head.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        head.path = headPath.cgPath
        
        lEye.fillColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lEye.path = eyePath.cgPath
        lEye.position.x = -10
        
        
        rEye.fillColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        rEye.path = eyePath.cgPath
        rEye.position.x = 25
        
        mouth.path = mouthPath.cgPath
        mouth.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mouth.position.x = 10
        mouth.position.y = 15
    }

}
