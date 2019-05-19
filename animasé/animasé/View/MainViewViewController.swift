//
//  MainViewViewController.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewViewController: UIViewController {
    
    // Init objects for firstView
    var lockView :UIView!
    var leftLockView :UIView!
    var rightLockView :UIView!
    var startButton :UIButton!
    
    // Init objects for secondary view
    var skyView :UIView!
    var cloudView :UIView!
    var cloud :Cloud!
    var cloud2 :Cloud!
    var cloud3 :Cloud!
    var treeView :UIView!
    var tree :Tree!
    var tree2 :Tree!
    
    var landView :UIView!
    var controlLeft :UIButton!
    var controlRight :UIButton!
    var controlAction :UIButton!
    
    // Init blur view for last view
    var resultView :UIView!
    
    // Init face view
    var faceView :UIView!
    var boyFace :Face!
    
    // Init controls view
    var arrowView :UIView!
    var leftArrow :Arrow!
    var leftButton :UIButton!
    var rightButton :UIButton!
    var rightArrow :Arrow!
    var actionButton :UIButton!
    
    // Init chest view
    var chestView :UIView!
    var chest :Chest!
    var isChestCenter :Bool = false
    
    // Init audio player
    var audioPlayer :AVAudioPlayer?
    var audioURL :URL?
    
    // Init successRate
    var successRate = 100
    var yayLabel :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yayLabel = UILabel()
        initLockView()
        
        initMainView()
        
        resultView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        resultView.backgroundColor = .white
        resultView.layer.opacity = 0.8
        resultView.isHidden = true
        
        addViews()
        
    }
    
    @objc func pressControl(sender: UIButton!) {
        if sender.accessibilityIdentifier == "left" {
            if faceView.frame.minX > self.view.frame.minX {
                UIView.animate(withDuration: 0.21) {
                    self.faceView.layer.position.x -= 10
                }
                boyFace.lookLeft()
            }
        }
        else if sender.accessibilityIdentifier == "right" {
            if faceView.frame.maxX < self.view.frame.maxX {
                UIView.animate(withDuration: 0.21) {
                    self.faceView.layer.position.x += 10
                }
                boyFace.lookRight()
            }
        }
        else if sender.accessibilityIdentifier == "action" {
            
            if chestView.center == CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2) {
                actionButton.isEnabled = false
                animateChest()
            }
            
            // detect collision!
            if faceView.frame.intersects(chestView.frame) && isChestCenter == false {
                audioPlayer?.stop()
                addSoundFX(audio: "blastFX",isRepeat: false)
                chestView.layer.opacity = 0
                chestView.layer.position = CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2)
                resultView.isHidden = false
                
                UIView.animate(withDuration: 1) {
                    self.resultView.layer.opacity = 0.3
                    self.chestView.layer.opacity = 1
                }
                isChestCenter = true
            }
        }
    }

    func animateChest() {
        if successRate <= Int.random(in: 1...100) {
            print("fail")
            self.chestView.transform = CGAffineTransform(rotationAngle: -0.2)
            addSoundFX(audio: "drumSample",isRepeat: true)
            UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.chestView.transform = CGAffineTransform(rotationAngle: 0.2)
            })
            DispatchQueue.global().async {
                for _ in 1...2 {
                    sleep(1)
                }
                DispatchQueue.main.async {
                    self.actionButton.isEnabled = true
                    self.chestView.layer.removeAllAnimations()
                    self.chestView.transform = CGAffineTransform(rotationAngle: 0)
                    self.audioPlayer?.stop()
                }
                self.boyFace.beSad()
            }
        }
        else if successRate >= Int.random(in: 1...100) {
            print("success")
            self.chestView.transform = CGAffineTransform(rotationAngle: -0.2)
            addSoundFX(audio: "drumSample",isRepeat: true)
            UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.chestView.transform = CGAffineTransform(rotationAngle: 0.2)
            })
            DispatchQueue.global().async {
                for _ in 1...2 {
                    sleep(1)
                }
                DispatchQueue.main.async {
                    self.actionButton.isEnabled = true
                    self.chestView.layer.removeAllAnimations()
                    self.chestView.transform = CGAffineTransform(rotationAngle: 0)
                    if let chestLayers = self.chestView.layer.sublayers {
                        for layer in chestLayers {
                            if layer.name == "chestLid" {
                                layer.removeFromSuperlayer()
                            }
                        }
                    }
                    self.audioPlayer?.stop()
                    self.yayLabel.text = "YAY"
                    self.yayLabel.font = self.yayLabel.font.withSize(60)
                    self.yayLabel.frame = CGRect(x: self.view.frame.maxX/2 - 50, y: self.view.frame.maxY/2 - 100, width: 200, height: 100)
                    self.addSoundFX(audio: "firework", isRepeat: false)
                    self.boyFace.beHappy()
                }
            }
        }
    }
    
    func addSoundFX(audio: String, isRepeat: Bool) {
        
        do {
            audioURL = Bundle.main.url(forResource: audio, withExtension: "wav")
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = audioPlayer else { return }
            if isRepeat == true {
                player.numberOfLoops = -1
            }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func initLockView() {
        lockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        
        lockView.backgroundColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1)
        
        leftLockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX/2, height: self.view.frame.maxY))
        rightLockView = UIView(frame: CGRect(x: self.view.frame.maxX/2, y: 0, width: self.view.frame.maxX/2, height: self.view.frame.maxY))
        
        let circleLockPath = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2), radius: self.view.frame.maxX/8, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let leftTrianglePath = UIBezierPath()
        leftTrianglePath.move(to: .zero)
        leftTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2))
        leftTrianglePath.addLine(to: CGPoint(x: 0, y: self.view.frame.maxY))
        leftTrianglePath.addLine(to: .zero)
        
        let rightTrianglePath = UIBezierPath()
        rightTrianglePath.move(to: CGPoint(x: self.view.frame.maxX/2, y: 0))
        rightTrianglePath.addLine(to: CGPoint(x: 0, y: self.view.frame.maxY/2))
        rightTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY))
        rightTrianglePath.addLine(to: CGPoint(x: self.view.frame.maxX/2, y: 0))
        
        let circleLock = CAShapeLayer()
        let leftTriangle = CAShapeLayer()
        let rightTriangle = CAShapeLayer()

        circleLock.path = circleLockPath.cgPath
        leftTriangle.path = leftTrianglePath.cgPath
        rightTriangle.path = rightTrianglePath.cgPath
        
        startButton = UIButton(type: .system)
        startButton.setTitle("Open", for: .normal)
        startButton.addTarget(self, action: #selector(startApp), for: .touchDown)
        startButton.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 100, height: 100)
        
        startButton.layer.position.x -= 50
        startButton.layer.position.y -= 50
        
        
        lockView.addSubview(leftLockView)
        leftLockView.layer.addSublayer(leftTriangle)
        leftLockView.layer.addSublayer(circleLock)
        
        lockView.addSubview(rightLockView)
        rightLockView.layer.addSublayer(rightTriangle)
        
        lockView.addSubview(startButton)
    }
    
    func initMainView() {
        
        // Init landView
        landView = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - (self.view.frame.maxY / 3), width: self.view.frame.maxX, height: self.view.frame.maxY / 3))
        landView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        // Init skyView
        skyView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        skyView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        cloudView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY/4))
        cloud = Cloud()
        cloud.cloud.position.y += 100
        cloud.cloud.position.x += 90
        
        cloud2 = Cloud()
        cloud2.cloud.position.y += 190
        cloud2.cloud.position.x += 220
        cloud3 = Cloud()
        cloud3.cloud.position.y += 90
        cloud3.cloud.position.x += 330
        
        cloudView.layer.addSublayer(cloud.cloud)
        cloudView.layer.addSublayer(cloud2.cloud)
        cloudView.layer.addSublayer(cloud3.cloud)
        
        treeView = UIView(frame: CGRect(x: 0, y: self.cloudView.frame.maxY, width: self.view.frame.maxX
            , height: self.skyView.frame.maxY - self.cloudView.frame.maxY))
        
        tree = Tree()
        tree.stick.position.x += 70
        tree.tree.position.x += 72
        tree.stick.position.y += 280
        tree.tree.position.y += 280
        
        tree2 = Tree()
        tree2.stick.position.x += 250
        tree2.tree.position.x += 252
        tree2.stick.position.y += 280
        tree2.tree.position.y += 280
        
        treeView.layer.addSublayer(tree.stick)
        treeView.layer.addSublayer(tree.tree)
        treeView.layer.addSublayer(tree2.stick)
        treeView.layer.addSublayer(tree2.tree)


        
        // Init faceView
        faceView = UIView(frame: CGRect(x: self.view.frame.maxX / 3, y: (skyView.frame.maxY / 2) + 60, width: 100, height: 100))
        boyFace = Face()
        boyFace.head.position.x += 50
        boyFace.head.position.y += 20
        boyFace.lEye.position.y += 20
        boyFace.rEye.position.y += 20
        boyFace.mouth.position.y += 50
        
        // Init controls view
        arrowView = UIView(frame: CGRect(x: landView.frame.minX + 5, y: landView.frame.minY + 5, width: landView.frame.maxX - 10, height: landView.frame.maxY - 10))
        leftArrow = Arrow(isReversed: true)
        rightArrow = Arrow(isReversed: false)
        
        leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x:  20, y: 80, width: 100, height: 100)
        leftArrow.arrowHead.position.x += 40
        leftArrow.stick.position.x += 40
        leftButton.layer.addSublayer(leftArrow.arrowHead)
        leftButton.layer.addSublayer(leftArrow.stick)
        leftButton.accessibilityIdentifier = "left"
        leftButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        rightButton = UIButton(type: .system)
        rightButton.frame = CGRect(x: 120, y: 80, width: 100, height: 100)
        rightArrow.arrowHead.position.x += 20
        rightArrow.stick.position.x += 20
        rightButton.layer.addSublayer(rightArrow.arrowHead)
        rightButton.layer.addSublayer(rightArrow.stick)
        rightButton.accessibilityIdentifier = "right"
        rightButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = .black
        actionButton.frame = CGRect(x: 270, y: 80, width: 70, height: 70)
        actionButton.layer.cornerRadius = 38
        actionButton.setTitle("A", for: .normal)
        actionButton.titleLabel?.font = UIFont(name: "Arial", size: CGFloat(40))
        actionButton.accessibilityIdentifier = "action"
        actionButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        arrowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        chest = Chest()
        chest.chest.position.x += 10
        chest.chest.position.y += 65
        chest.chestLid.position.x += 10
        chest.chestLid.position.y += 65
        chest.chestLock.position.x += 10
        chest.chestLock.position.y += 65
        
        chestView = UIView(frame: CGRect(x: skyView.frame.maxX - 100, y: skyView.frame.maxY - 400, width: 100, height: 100))
        chestView.layer.addSublayer(chest.chestLid)
        
        chestView.layer.addSublayer(chest.chest)
        chestView.layer.addSublayer(chest.chestLock)
    }
    
    func addViews() {
        // add views to main viewcontroller
        self.view.addSubview(skyView)
        self.view.addSubview(cloudView)
        self.view.addSubview(treeView)
        self.view.addSubview(landView)
        self.view.addSubview(faceView)
        self.view.addSubview(resultView)
        self.view.addSubview(arrowView)
        self.view.addSubview(chestView)
        self.view.addSubview(lockView)
        
        faceView.layer.addSublayer(boyFace.head)
        faceView.layer.addSublayer(boyFace.lEye)
        faceView.layer.addSublayer(boyFace.rEye)
        faceView.layer.addSublayer(boyFace.mouth)
        
        arrowView.addSubview(leftButton)
        arrowView.addSubview(rightButton)
        arrowView.addSubview(actionButton)
        
        resultView.addSubview(yayLabel)
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
            addSoundFX(audio: "mainTheme",isRepeat: true)
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

