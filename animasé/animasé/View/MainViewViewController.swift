//
//  MainViewViewController.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {
    
    // Init objects
    var landView :UIView!
    var controlLeft :UIButton!
    var controlRight :UIButton!
    var controlAction :UIButton!
    
    var skyView :UIView!
    
    var faceView :UIView!
    var boyFace :Face!
    
    var arrowView :UIView!
    var arrow :Arrow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init landView
        landView = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - (self.view.frame.maxY / 3), width: self.view.frame.maxX, height: self.view.frame.maxY / 3))
        landView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        // Init skyView
        skyView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        skyView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        // Init faceView
        faceView = UIView(frame: CGRect(x: self.view.frame.maxX / 3, y: (skyView.frame.maxY / 2), width: self.view.frame.maxX / 3, height: self.view.frame.maxY / 5))
        boyFace = Face()
        
        arrowView = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        arrow = Arrow()
        
        
        
        // add views to main viewcontroller
        self.view.addSubview(skyView)
        self.view.addSubview(landView)
        self.view.addSubview(faceView)
        self.view.addSubview(arrowView)
        faceView.layer.addSublayer(boyFace.head)
        faceView.layer.addSublayer(boyFace.lEye)
        faceView.layer.addSublayer(boyFace.rEye)
        faceView.layer.addSublayer(boyFace.mouth)
        arrowView.layer.addSublayer(arrow.arrowHead)
        arrowView.layer.addSublayer(arrow.stick)
        
     //   landView.addSubview(<#T##view: UIView##UIView#>)
     //   landView.addSubview(<#T##view: UIView##UIView#>)

        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func ger() {
        animHead()
    }
    func animHead() {
        UIView.animate(withDuration: 3) {
            self.boyFace.head.position = CGPoint(x: 20, y: 20)
        }
        
        }
    
}

