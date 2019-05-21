//
//  ResultView.swift
//  animasé
//
//  Created by William Inx on 21/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class ResultView {
    // Init blur view for last view
    var resultView :UIView!
    var yayLabel :UILabel!
    
    
    init(main :UIViewController) {
        createView(main :main)
        resultView.addSubview(yayLabel)
    }
    
    fileprivate func createView(main :UIViewController) {
        yayLabel = UILabel()
        resultView = UIView(frame: CGRect(x: 0, y: 0, width: main.view.frame.maxX, height: main.view.frame.maxY))
        resultView.backgroundColor = .white
        resultView.layer.opacity = 0.8
        resultView.isHidden = true
    }
    
    func focusChest(main: UIViewController) {
        soundAudio.audioPlayer?.stop()
        soundAudio.addSoundFX(audio: "blastFX",isRepeat: false)
        masterChestView.chestView.layer.opacity = 0
        masterChestView.chestView.layer.position = CGPoint(x: main.view.frame.maxX / 2, y: main.view.frame.maxY / 2)
        masterResultView.resultView.isHidden = false
        
        UIView.animate(withDuration: 1) {
            masterResultView.resultView.layer.opacity = 0.3
            masterChestView.chestView.layer.opacity = 1
        }
        masterChestView.isChestCenter = true
    }
}
