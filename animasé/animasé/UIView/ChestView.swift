//
//  ChestView.swift
//  animasé
//
//  Created by William Inx on 21/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class ChestView {
    // Init chest view
    var chestView :UIView!
    var chestImage :UIImage!
    var chestImageView :UIImageView!
    var isChestCenter :Bool = false
    
    var soundAudio :SoundAudio!
    
    init(main :UIViewController) {
        createChest(main :main)
        chestView.addSubview(chestImageView)
    }
    
    fileprivate func createChest(main :UIViewController) {
        // Init chestView
        soundAudio = SoundAudio()
        chestView = UIView(frame: CGRect(x: masterSceneryView.skyView.frame.maxX - 100, y: masterSceneryView.skyView.frame.maxY - 380, width: 100, height: 100))
        chestImage = UIImage(named: "chest_closed")
        chestImageView = UIImageView(image: chestImage)
        chestImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    fileprivate func chestFail() {
        self.chestView.transform = CGAffineTransform(rotationAngle: -0.2)
        soundAudio.addSoundFX(audio: "drumSample",isRepeat: true)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.chestView.transform = CGAffineTransform(rotationAngle: 0.2)
        })
        
        UIView.animate(withDuration: 10, animations: {
            masterResultView.resultView.layer.backgroundColor = UIColor.black.cgColor
            masterResultView.resultView.layer.opacity = 0.9
        })
        
        DispatchQueue.global().async {
            for _ in 1...10 {
                sleep(1)
            }
            DispatchQueue.main.async {
                masterControlView.actionButton.isEnabled = true
                self.chestView.layer.removeAllAnimations()
                self.chestView.transform = CGAffineTransform(rotationAngle: 0)
                self.soundAudio.audioPlayer?.stop()
                masterResultView.resultView.layer.backgroundColor = UIColor.white.cgColor
                masterResultView.resultView.layer.opacity = 0.3
            }
        }
    }
    
    fileprivate func chestSuccess(main :UIViewController) {
        self.chestView.transform = CGAffineTransform(rotationAngle: -0.2)
        soundAudio.addSoundFX(audio: "drumSample",isRepeat: true)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.chestView.transform = CGAffineTransform(rotationAngle: 0.2)
        })
        UIView.animate(withDuration: 10, animations: {
            masterResultView.resultView.layer.backgroundColor = UIColor.black.cgColor
            masterResultView.resultView.layer.opacity = 0.9
        })
        
        DispatchQueue.global().async {
            for _ in 1...10 {
                sleep(1)
            }
            DispatchQueue.main.async {
                masterControlView.actionButton.isEnabled = true
                self.chestView.layer.removeAllAnimations()
                self.chestView.transform = CGAffineTransform(rotationAngle: 0)
                if let chestLayers = self.chestView.layer.sublayers {
                    for layer in chestLayers {
                        if layer.name == "chestLid" {
                            layer.removeFromSuperlayer()
                        }
                    }
                }
                self.soundAudio.audioPlayer?.stop()
                self.chestImageView.image = UIImage(named: "chest_open")
                masterResultView.yayLabel.text = "YAY"
                masterResultView.yayLabel.font = masterResultView.yayLabel.font.withSize(60)
                masterResultView.yayLabel.textColor = .white
                masterResultView.yayLabel.frame = CGRect(x: main.view.frame.maxX/2 - 50, y: main.view.frame.maxY/2 - 100, width: 200, height: 100)
                self.soundAudio.addSoundFX(audio: "yay", isRepeat: false)
            }
        }
    }
    
    func animateChest(main :UIViewController) {
        if successRate <= Int.random(in: 1...100) {
            chestFail()
        }
        else if successRate >= Int.random(in: 1...100) {
            chestSuccess(main: main)
        }
    }
}
