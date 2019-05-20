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
    
    // Init scenery view
    var skyView :UIView!
    var skyImage :UIImage!
    var skyImageView :UIImageView!
    var treeImage :UIImage!
    var treeImageView :UIImageView!
    var treeImageView2 :UIImageView!
    var treeView :UIView!
    var treeView2 :UIView!
    var cloudImage :UIImage!
    var cloudImageView :UIImageView!
    var cloudImageView2 :UIImageView!
    var cloudView: UIView!
    var cloudView2 :UIView!
    var landView :UIView!
    var landImage :UIImage!
    var landImageView :UIImageView!
    
    // Init blur view for last view
    var resultView :UIView!
    
    // Init face view
    var faceView :UIView!
    var cookieFace :UIImage!
    var cookieFaceView :UIImageView!
    
    // Init controls view
    var controlView :UIView!
    var leftArrow :Arrow!
    var leftButton :UIButton!
    var rightArrow :Arrow!
    var rightButton :UIButton!
    var actionButton :UIButton!
    
    // Init chest view
    var chestView :UIView!
    var chestImage :UIImage!
    var chestImageView :UIImageView!
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
                    self.cookieFaceView.image = UIImage(named: "cookman_l_close")
                }
                self.cookieFaceView.image = UIImage(named: "cookman_l_open")
            }
        }
        else if sender.accessibilityIdentifier == "right" {
            if faceView.frame.maxX < self.view.frame.maxX {
                UIView.animate(withDuration: 0.21) {
                    self.faceView.layer.position.x += 10
                    self.cookieFaceView.image = UIImage(named: "cookman_r_close")
                }
                self.cookieFaceView.image = UIImage(named: "cookman_r_open")
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
                for _ in 1...10 {
                    sleep(1)
                }
                DispatchQueue.main.async {
                    self.actionButton.isEnabled = true
                    self.chestView.layer.removeAllAnimations()
                    self.chestView.transform = CGAffineTransform(rotationAngle: 0)
                    self.audioPlayer?.stop()
                }
            }
        }
        else if successRate >= Int.random(in: 1...100) {
            print("success")
            self.chestView.transform = CGAffineTransform(rotationAngle: -0.2)
            addSoundFX(audio: "drumSample",isRepeat: true)
            UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.chestView.transform = CGAffineTransform(rotationAngle: 0.2)
            })
            UIView.animate(withDuration: 10, animations: {
                self.resultView.layer.backgroundColor = UIColor.black.cgColor
                self.resultView.layer.opacity = 0.9
            })
            DispatchQueue.global().async {
                for _ in 1...10 {
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
                    self.chestImageView.image = UIImage(named: "chest_open")
                    self.yayLabel.text = "YAY"
                    self.yayLabel.font = self.yayLabel.font.withSize(60)
                    self.yayLabel.frame = CGRect(x: self.view.frame.maxX/2 - 50, y: self.view.frame.maxY/2 - 100, width: 200, height: 100)
                    self.addSoundFX(audio: "yay", isRepeat: false)
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
        
        lockView.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 64/255, alpha: 1)
        
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
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
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
        
        landImage = UIImage(named: "grass")
        landImageView = UIImageView(image: landImage)
        landImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY / 3)
        
        landView.addSubview(landImageView)
        
        // Init skyView
        skyView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        
        skyImage = UIImage(named: "sky.png")
        skyImageView = UIImageView(image: skyImage)
        skyImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.maxX
            , height: self.view.frame.maxY)
        
        skyView.addSubview(skyImageView)
        
        // Init trees
        treeView = UIView(frame: CGRect(x: -80, y: 250, width: 300, height: 400))
        treeView2 = UIView(frame: CGRect(x: 200, y: 250, width: 300, height: 400))
        
        treeImage = UIImage(named: "tree")
        treeImageView = UIImageView(image: treeImage)
        treeImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        treeImageView2 = UIImageView(image: treeImage)
        treeImageView2.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        treeView.addSubview(treeImageView)
        treeView2.addSubview(treeImageView2)
        
        // Init clouds
        cloudView = UIView(frame: CGRect(x: 0, y: 50, width: 200, height: 100))
        cloudView2 = UIView(frame: CGRect(x: 250, y: 70, width: 200, height: 100))
        
        cloudImage = UIImage(named: "cloud")
        cloudImageView = UIImageView(image: cloudImage)
        cloudImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        
        cloudImageView2 = UIImageView(image: cloudImage)
        cloudImageView2.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        
        cloudView.addSubview(cloudImageView)
        cloudView2.addSubview(cloudImageView2)

        
        // Init faceView
        faceView = UIView(frame: CGRect(x: self.view.frame.maxX / 3, y: (skyView.frame.maxY / 2) + 60, width: 100, height: 100))
        
        cookieFace = UIImage(named: "cookman_r_open")
        cookieFaceView = UIImageView(image: cookieFace)
        cookieFaceView.frame = CGRect(x: 0, y: 0, width: 100
            , height: 100)
        faceView.addSubview(cookieFaceView)
        
        
        // Init controls
        controlView = UIView(frame: CGRect(x: landView.frame.minX + 5, y: landView.frame.minY + 5, width: landView.frame.maxX - 10, height: landView.frame.maxY - 10))
        leftArrow = Arrow(isReversed: true)
        rightArrow = Arrow(isReversed: false)
        
        leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x:  20, y: 80, width: 100, height: 100)
        leftButton.accessibilityIdentifier = "left"
        leftButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        leftArrow.arrowHead.position.x += 40
        leftArrow.stick.position.x += 40
        leftButton.layer.addSublayer(leftArrow.arrowHead)
        leftButton.layer.addSublayer(leftArrow.stick)
        
        
        rightButton = UIButton(type: .system)
        rightButton.frame = CGRect(x: 120, y: 80, width: 100, height: 100)
        rightButton.accessibilityIdentifier = "right"
        rightButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        rightArrow.arrowHead.position.x += 20
        rightArrow.stick.position.x += 20
        rightButton.layer.addSublayer(rightArrow.arrowHead)
        rightButton.layer.addSublayer(rightArrow.stick)
        
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = .black
        actionButton.frame = CGRect(x: 270, y: 80, width: 70, height: 70)
        actionButton.layer.cornerRadius = 38
        actionButton.setTitle("A", for: .normal)
        actionButton.titleLabel?.font = UIFont(name: "Arial", size: CGFloat(40))
        actionButton.accessibilityIdentifier = "action"
        actionButton.addTarget(self, action: #selector(pressControl(sender:)), for: .touchDown)
        
        controlView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        
        // Init chestView
        chestView = UIView(frame: CGRect(x: skyView.frame.maxX - 100, y: skyView.frame.maxY - 380, width: 100, height: 100))
        chestImage = UIImage(named: "chest_closed")
        chestImageView = UIImageView(image: chestImage)
        chestImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        chestView.addSubview(chestImageView)
        
        
    }
    
    func addViews() {
        // add views to main viewcontroller
        self.view.addSubview(skyView)
        self.view.addSubview(landView)
        self.view.addSubview(treeView)
        self.view.addSubview(treeView2)
        self.view.addSubview(cloudView)
        self.view.addSubview(cloudView2)
        self.view.addSubview(faceView)
        self.view.addSubview(resultView)
        self.view.addSubview(controlView)
        self.view.addSubview(chestView)
        self.view.addSubview(lockView)

        controlView.addSubview(leftButton)
        controlView.addSubview(rightButton)
        controlView.addSubview(actionButton)
        
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

