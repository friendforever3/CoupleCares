//
//  UpdateGenderVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 25/12/21.
//

import UIKit

class UpdateGenderVC: UIViewController {
    
    @IBOutlet weak var vwMale: ViewCustom!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var vwFemale: ViewCustom!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var lblFemale: UILabel!
    @IBOutlet weak var vwOther: ViewCustom!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var lblOther: UILabel!
    
    var genderSelected : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if genderSelected == "1"{
            selectedVw(selected: vwMale)
        }else if genderSelected == "2"{
            selectedVw(selected: vwFemale)
        }else{
            selectedVw(selected: vwOther)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnMaleAction(_ sender: Any) {
        selectedVw(selected: vwMale)
        genderSelected = "1"
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        selectedVw(selected: vwFemale)
        genderSelected = "2"
    }
    
    @IBAction func btnOtherAction(_ sender: Any) {
        selectedVw(selected: vwOther)
        genderSelected = "3"
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if genderSelected == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgGender, control: ["OK"], topController: self)
        }else{
            updateGenderProfile()
        }
    }
    
    func selectedVw(selected:ViewCustom){
        
        let vws = [vwMale,vwFemale,vwOther]
        
        for vw in vws{
            
            if vw == selected{
                
                vw?.backgroundColor = UIColor(named: "appOrange")
                
                if selected == vwMale{
                    imgMale.image = UIImage(named: "male")
                    lblMale.textColor = .white
                }else if selected == vwFemale{
                    imgFemale.image = UIImage(named: "female")
                    lblFemale.textColor = .white
                }else if selected == vwOther{
                    imgOther.image = UIImage(named: "other")
                    lblOther.textColor = .white
                }
                
            }else{
                vw?.backgroundColor = .white
                vw?.borderColor = UIColor(named: "appOrange")
                
                if selected == vwMale{
                    
                    imgFemale.image = UIImage(named: "female2")
                    lblFemale.textColor = UIColor(named: "txtColor")
                    
                    imgOther.image = UIImage(named: "other2")
                    lblOther.textColor = UIColor(named: "txtColor")
                    
                }else if selected == vwFemale{
                    
                    imgMale.image = UIImage(named: "male2")
                    lblMale.textColor = UIColor(named: "txtColor")
                    
                    imgOther.image = UIImage(named: "other2")
                    lblOther.textColor = UIColor(named: "txtColor")
                    
                    
                }else if selected == vwOther{
                    
                    imgFemale.image = UIImage(named: "female2")
                    lblFemale.textColor = UIColor(named: "txtColor")
                    
                    imgMale.image = UIImage(named: "male2")
                    lblMale.textColor = UIColor(named: "txtColor")
                    
                    
                }
                
            }
            
        }
        
        
    }
    
    
}

//MARK: API
extension UpdateGenderVC{
    
    func updateGenderProfile(){
        
        UserViewModel.shared.updateProfile(keyName: "gender", value: genderSelected) { [weak self] (success,msg) in
            
            if success{
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
