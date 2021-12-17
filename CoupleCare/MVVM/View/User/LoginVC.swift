//
//  LoginVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
       // let vc = CoupleCaresTabbar.getVC(.CoupleCares)
        let vc = MobileNumVC.getVC(.Main)
        self.push(vc)
    }
    

}
