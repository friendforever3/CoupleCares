//
//  NameVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class NameVC: UIViewController {

    @IBOutlet weak var tfFullName: TextFieldCustom!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if tfFullName.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgFullName, control: ["OK"], topController: self)
        }else{
            RegisterModel.shared.fullName = tfFullName.text ?? ""
            pushToBday()
        }
    }
    
    func pushToBday(){
        let vc = BirthdayVC.getVC(.Main)
        self.push(vc)
    }
    

}
