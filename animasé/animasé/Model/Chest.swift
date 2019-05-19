//
//  Chest.swift
//  animasé
//
//  Created by William Inx on 16/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class Chest {
    let chestPath = UIBezierPath()
    let chest = CAShapeLayer()
    let chestLidPath = UIBezierPath(arcCenter: CGPoint(x: 50, y: 10), radius: CGFloat(50), startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
    let chestLockPath = UIBezierPath(arcCenter: CGPoint(x: 50, y: 0), radius: CGFloat(5), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
    let chestLock = CAShapeLayer()
    let chestLid = CAShapeLayer()
    
    init() {
        chestPath.move(to: .zero)
        chestPath.addLine(to: CGPoint(x: 100, y: 0))
        chestPath.addLine(to: CGPoint(x: 100, y: 40))
        chestPath.addLine(to: CGPoint(x: 0, y: 40))
        chestPath.addLine(to: .zero)

        
        chestLid.path = chestLidPath.cgPath
        chestLid.name = "chestLid"
        chestLock.path = chestLockPath.cgPath
        chestLock.name = "chestLock"
        chest.path = chestPath.cgPath
        chest.name = "chest"
        chestLid.fillColor = UIColor.orange.cgColor
        chestLock.fillColor = UIColor.yellow.cgColor
        chest.fillColor = UIColor.brown.cgColor
        
        
        
    }
}
