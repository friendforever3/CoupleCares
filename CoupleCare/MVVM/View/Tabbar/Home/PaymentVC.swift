//
//  PaymentVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class PaymentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnChangeAction(_ sender: Any) {
        let vc = PremiumPlanVC.getVC(.Home)
        self.push(vc)
    }
    

}
