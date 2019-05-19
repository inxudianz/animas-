//
//  Cloud.swift
//  animasé
//
//  Created by William Inx on 19/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class Cloud {
    let cloudPath = UIBezierPath()
    let cloud = CAShapeLayer()
    init() {
        
        cloudPath.addArc(withCenter: CGPoint(x: 0, y: 0), radius: CGFloat(20), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        cloudPath.addArc(withCenter: CGPoint(x: 20, y: 0), radius: CGFloat(20), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        cloudPath.addArc(withCenter: CGPoint(x: 50, y: 0), radius: CGFloat(20), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        cloud.path = cloudPath.cgPath
        cloud.fillColor = UIColor.white.cgColor
    }
}
