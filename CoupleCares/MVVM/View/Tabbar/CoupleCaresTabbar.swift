//
//  CoupleCaresTabbar.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class CoupleCaresTabbar: UITabBarController {

    let layerGradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layerGradient.colors = [UIColor(named: "startColor")?.cgColor, UIColor(named: "endColor")?.cgColor]
            layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
            layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
            layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            //self.tabBar.layer.addSublayer(layerGradient)
            self.tabBar.layer.insertSublayer(layerGradient, at: 0)
    }

    
}
