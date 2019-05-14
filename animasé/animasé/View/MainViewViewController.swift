//
//  MainViewViewController.swift
//  animasé
//
//  Created by William Inx on 14/05/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class MainViewViewController: UIViewController {
    
    var foo :UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foo = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        foo.backgroundColor = .blue
        
        self.view.addSubview(foo)
        
        
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

}
