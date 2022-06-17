//
//  UpdateBioVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 25/12/21.
//

import UIKit
import IQKeyboardManager

class UpdateBioVC: UIViewController {

    @IBOutlet weak var tfBio: IQTextView!
    
    var bioTxt : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfBio.text = bioTxt.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if tfBio.text.isEmptyOrWhitespace() {
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kBio, control: ["OK"], topController: self)
        }else{
            UpdateBioVC()
        }
    }
    
    
}

//MARK: API
extension UpdateBioVC{
    
    func UpdateBioVC(){
        UserViewModel.shared.updateProfile(keyName: "bio", value: tfBio.text ?? "") { [weak self] (success,msg) in
            if success{
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}

