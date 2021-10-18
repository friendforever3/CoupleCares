//
//  ProfileVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 09/10/21.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        let vc = EditProfileVC.getVC(.Profile)
        self.push(vc)
    }
    
    @IBAction func btnSettingAction(_ sender: Any) {
        let vc = ProfileSettingVC.getVC(.Profile)
        self.push(vc)
    }
    
   

}
