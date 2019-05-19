//
//  Tree.swift
//  animasé
//
//  Created by William Inx on 19/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class Tree {
    let treePath = UIBezierPath()
    let stickPath = UIBezierPath()
    
    let stick = CAShapeLayer()
    let tree = CAShapeLayer()
    
    init() {
        stickPath.move(to: .zero)
        stickPath.addLine(to: CGPoint(x: 0, y: 100))
        stickPath.addLine(to: CGPoint(x: 5, y: 100))
        stickPath.addLine(to: CGPoint(x: 5, y: 0))
        stickPath.addLine(to: CGPoint(x: 0, y: 0))
        
        stick.path = stickPath.cgPath
        stick.fillColor = UIColor.brown.cgColor

        treePath.move(to: .zero)
        treePath.addLine(to: CGPoint(x: -30, y: 0))
        treePath.addLine(to: CGPoint(x: 0, y: 20))
        treePath.addLine(to: CGPoint(x: -30, y: 20))
        treePath.addLine(to: CGPoint(x: 0, y: 40))
        treePath.addLine(to: CGPoint(x: 30, y: 20))
        treePath.addLine(to: CGPoint(x: 0, y: 20))
        treePath.addLine(to: CGPoint(x: 30, y: 0))
        treePath.addLine(to: CGPoint(x: 0, y: 0))
        
        tree.path = treePath.cgPath
        tree.fillColor = UIColor.green.cgColor






    }
}
