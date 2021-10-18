//
//  MatchVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class MatchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.popVc()
    }
    @IBAction func btnStartConvAction(_ sender: Any) {
        self.popVc()
    }
    @IBAction func btnSwipeAction(_ sender: Any) {
        self.popVc()
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
