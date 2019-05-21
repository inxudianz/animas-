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
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        addViews()
    }
    
    func initViews() {
        soundAudio = SoundAudio()
        masterLockView = LockView(main: self)
        masterSceneryView = SceneryView(main: self)
        masterFaceView = FaceView(main: self)
        masterChestView = ChestView(main: self)
        masterControlView = ControlView(main: self)
        masterResultView = ResultView(main: self)
    }
    
    func addViews() {
        // add views to main viewcontroller
        self.view.addSubview(masterSceneryView.skyView)
        self.view.addSubview(masterSceneryView.landView)
        self.view.addSubview(masterSceneryView.treeView)
        self.view.addSubview(masterSceneryView.treeView2)
        self.view.addSubview(masterSceneryView.cloudView)
        self.view.addSubview(masterSceneryView.cloudView2)
        self.view.addSubview(masterFaceView.faceView)
        self.view.addSubview(masterResultView.resultView)
        self.view.addSubview(masterChestView.chestView)
        self.view.addSubview(masterControlView.controlView)
        self.view.addSubview(masterLockView.lockView)
    
    }
    
}

