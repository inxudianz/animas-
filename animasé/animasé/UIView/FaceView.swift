//
//  FaceView.swift
//  animasé
//
//  Created by William Inx on 21/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class FaceView {
    // Init face view
    var faceView :UIView!
    var cookieFace :UIImage!
    var cookieFaceView :UIImageView!
    
    init(main :UIViewController) {
        createFace(main :main)
        faceView.addSubview(cookieFaceView)
    }
    
    fileprivate func createFace(main :UIViewController) {
        // Init faceView
        faceView = UIView(frame: CGRect(x: main.view.frame.maxX / 3, y: (masterSceneryView.skyView.frame.maxY / 2) + 60, width: 100, height: 100))
        cookieFace = UIImage(named: "cookman_r_open")
        cookieFaceView = UIImageView(image: cookieFace)
        cookieFaceView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    func moveLeft(main :UIViewController) {
        if faceView.frame.minX > main.view.frame.minX {
            UIView.animate(withDuration: 0.21) {
                self.faceView.layer.position.x -= 10
            }
            cookieFaceView.image = UIImage(named: "cookman_l_open")
        }
        else {
            successRate = 100
        }
    }
    
    func moveRight(main :UIViewController) {
        if faceView.frame.maxX < main.view.frame.maxX {
            UIView.animate(withDuration: 0.21) {
                self.faceView.layer.position.x += 10
            }
            cookieFaceView.image = UIImage(named: "cookman_r_open")
        }
    }
}
