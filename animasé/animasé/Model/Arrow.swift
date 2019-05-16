//
//  Arrow.swift
//  animasé
//
//  Created by William Inx on 16/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class Arrow {
    var stickPath:UIBezierPath = UIBezierPath()
    var stick = CAShapeLayer()
    var arrowHeadPath:UIBezierPath = UIBezierPath()
    var arrowHead = CAShapeLayer()
    init(isReversed: Bool) {
        if isReversed == false {
            addPoint()
        }
        else {
            addPointReversed()
        }
        stick.path = stickPath.cgPath
        arrowHead.path = arrowHeadPath.cgPath
        
    }
    
    fileprivate func addPoint() {
        stickPath.move(to: CGPoint(x: 40, y: 50))
        stickPath.addLine(to: CGPoint(x: 40, y: 70))
        stickPath.addLine(to: CGPoint(x: 0, y: 70))
        stickPath.addLine(to: CGPoint(x: 0, y: 50))
        stickPath.addLine(to: CGPoint(x: 40, y: 50))
        
        arrowHeadPath.move(to: CGPoint(x: 60, y: 60))
        arrowHeadPath.addLine(to: CGPoint(x: 30, y: 30))
        arrowHeadPath.addLine(to: CGPoint(x: 30, y: 90))
        arrowHeadPath.addLine(to: CGPoint(x: 60, y: 60))
    }
    func addPointReversed() {
        stickPath.move(to: CGPoint(x: 40, y: 50))
        stickPath.addLine(to: CGPoint(x: 40, y: 70))
        stickPath.addLine(to: CGPoint(x: 0, y: 70))
        stickPath.addLine(to: CGPoint(x: 0, y: 50))
        stickPath.addLine(to: CGPoint(x: 40, y: 50))
        
        arrowHeadPath.move(to: CGPoint(x: -30, y: 60))
        arrowHeadPath.addLine(to: CGPoint(x: 0, y: 30))
        arrowHeadPath.addLine(to: CGPoint(x: 0, y: 90))
        arrowHeadPath.addLine(to: CGPoint(x: -30, y: 60))
    }
}
