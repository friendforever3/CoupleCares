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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
       // let vc = CoupleCaresTabbar.getVC(.CoupleCares)
        let vc = MobileNumVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnFacebookLoginAction(_ sender: Any) {
        SocialLoginMngr.shared.signinWithFacebook(controller: self)
    }
    
    
    @IBAction func btnGoogleSIgninAction(_ sender: Any) {
        SocialLoginMngr.shared.siginWithGoogle(view: self.view, ViewController: self)
    }
    
}
