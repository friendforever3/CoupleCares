//
//  OTPVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class OTPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        let vc = NameVC.getVC(.Main)
        self.push(vc)
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
