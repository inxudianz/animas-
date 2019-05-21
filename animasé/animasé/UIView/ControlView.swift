//
//  ControlView.swift
//  animasé
//
//  Created by William Inx on 21/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class ControlView {
    // Init controls view
    var controlView :UIView!
    var leftArrow :Arrow!
    var leftButton :UIButton!
    var rightArrow :Arrow!
    var rightButton :UIButton!
    var actionButton :UIButton!
    
    var main :UIViewController
    
    init(main: UIViewController) {
        self.main = main
        
        initViews()
        createLeftButton()
        createRightButton()
        createActionButton()
        
        controlView.addSubview(leftButton)
        controlView.addSubview(rightButton)
        controlView.addSubview(actionButton)
    }
    
    fileprivate func initViews() {
        // Init controls
        controlView = UIView(frame: CGRect(x: masterSceneryView.landView.frame.minX + 5, y: masterSceneryView.landView.frame.minY + 5, width: masterSceneryView.landView.frame.maxX - 10, height: masterSceneryView.landView.frame.maxY - 10))
        controlView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        leftArrow = Arrow(isReversed: true)
        rightArrow = Arrow(isReversed: false)
        
        leftButton = UIButton(type: .system)
        rightButton = UIButton(type: .system)
        actionButton = UIButton(type: .system)
    }
    
    fileprivate func createLeftButton() {
        leftButton.frame = CGRect(x:  20, y: 80, width: 100, height: 100)
        leftButton.accessibilityIdentifier = "left"
        leftButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        leftArrow.arrowHead.position.x += 40
        leftArrow.stick.position.x += 40
        leftButton.layer.addSublayer(leftArrow.arrowHead)
        leftButton.layer.addSublayer(leftArrow.stick)
    }
    
    fileprivate func createRightButton() {
        rightButton.frame = CGRect(x: 120, y: 80, width: 100, height: 100)
        rightButton.accessibilityIdentifier = "right"
        rightButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        rightArrow.arrowHead.position.x += 20
        rightArrow.stick.position.x += 20
        rightButton.layer.addSublayer(rightArrow.arrowHead)
        rightButton.layer.addSublayer(rightArrow.stick)
    }
    
    fileprivate func createActionButton() {
        actionButton.backgroundColor = .red
        actionButton.frame = CGRect(x: 270, y: 80, width: 70, height: 70)
        actionButton.layer.cornerRadius = 38
        actionButton.setTitle("A", for: .normal)
        actionButton.tintColor = .white
        actionButton.titleLabel?.font = UIFont(name: "Arial", size: CGFloat(40))
        actionButton.accessibilityIdentifier = "action"
        actionButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
    }
    
    @objc func pressControl(sender: UIButton!) {
        if sender.accessibilityIdentifier == "left" {
            sender.layer.opacity = 0.7
            UIView.animate(withDuration: 0.2) {
                sender.layer.opacity = 1
            }
            masterFaceView.moveLeft(main: main)
        }
        else if sender.accessibilityIdentifier == "right" {
            sender.layer.opacity = 0.7
            UIView.animate(withDuration: 0.2) {
                sender.layer.opacity = 1
            }
            masterFaceView.moveRight(main: main)
        }
        else if sender.accessibilityIdentifier == "action" {
            
            if masterChestView.chestView.center == CGPoint(x: main.view.frame.maxX / 2, y: main.view.frame.maxY / 2) {
                actionButton.isEnabled = false
                masterChestView.animateChest(main: main)
            }
            // detect collision
            if masterFaceView.faceView.frame.intersects(masterChestView.chestView.frame) && masterChestView.isChestCenter == false {
                masterResultView.focusChest(main: main)
            }
        }
    }
}
