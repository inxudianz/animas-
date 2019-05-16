//
//  Stickman.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import Foundation
import UIKit

class StickmanPath {
    var head :CAShapeLayer?
    var body :CAShapeLayer?
    var lArm :CAShapeLayer?
    var rArm :CAShapeLayer?
    var lLeg :CAShapeLayer?
    var rLeg :CAShapeLayer?
    
    init(head: CAShapeLayer, body: CAShapeLayer, lArm: CAShapeLayer, rArm: CAShapeLayer, lLeg: CAShapeLayer, rLeg: CAShapeLayer) {
        self.head = head
        self.body = body
        self.lArm = lArm
        self.rArm = rArm
        self.lLeg = lLeg
        self.rLeg = rLeg
    }
}
