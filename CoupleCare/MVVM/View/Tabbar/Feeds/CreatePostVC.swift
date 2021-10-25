//
//  CreatePostVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 18/10/21.
//

import UIKit

class CreatePostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    

}
