//
//  SceneryView.swift
//  animasé
//
//  Created by William Inx on 21/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class SceneryView {
    // Init objects for scenery view
    var sceneryView :UIView!
    
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
    
    init(main :UIViewController) {
        
        initViews(main :main)
        createLand(main :main)
        createSky(main :main)
        createTree(main :main)
        createCloud(main :main)
        
        landView.addSubview(landImageView)
        skyView.addSubview(skyImageView)
        treeView.addSubview(treeImageView)
        treeView2.addSubview(treeImageView2)
        cloudView.addSubview(cloudImageView)
        cloudView2.addSubview(cloudImageView2)
    }
    
    fileprivate func initViews(main :UIViewController) {
        landView = UIView(frame: CGRect(x: 0, y: main.view.frame.maxY - (main.view.frame.maxY / 3), width: main.view.frame.maxX, height: main.view.frame.maxY / 3))
        skyView = UIView(frame: CGRect(x: 0, y: 0, width: main.view.frame.maxX, height: main.view.frame.maxY))
        treeView = UIView(frame: CGRect(x: -80, y: 250, width: 300, height: 400))
        treeView2 = UIView(frame: CGRect(x: 200, y: 250, width: 300, height: 400))
        cloudView = UIView(frame: CGRect(x: 0, y: 50, width: 200, height: 100))
        cloudView2 = UIView(frame: CGRect(x: 250, y: 70, width: 200, height: 100))
    }
    
    fileprivate func createLand(main :UIViewController) {
        // Init landView
        landImage = UIImage(named: "grass")
        landImageView = UIImageView(image: landImage)
        landImageView.frame = CGRect(x: 0, y: 0, width: main.view.frame.maxX, height: main.view.frame.maxY / 3)
    }
    
    fileprivate func createSky(main :UIViewController) {
        // Init skyView
        skyImage = UIImage(named: "sky.png")
        skyImageView = UIImageView(image: skyImage)
        skyImageView.frame = CGRect(x: 0, y: 0, width: main.view.frame.maxX
            , height: main.view.frame.maxY)
    }
    
    fileprivate func createTree(main :UIViewController) {
        // Init trees
        treeImage = UIImage(named: "tree")
        treeImageView = UIImageView(image: treeImage)
        treeImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        treeImageView2 = UIImageView(image: treeImage)
        treeImageView2.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
    }
    
    fileprivate func createCloud(main :UIViewController) {
        // Init clouds
        cloudImage = UIImage(named: "cloud")
        cloudImageView = UIImageView(image: cloudImage)
        cloudImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        cloudImageView2 = UIImageView(image: cloudImage)
        cloudImageView2.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
    }
}
