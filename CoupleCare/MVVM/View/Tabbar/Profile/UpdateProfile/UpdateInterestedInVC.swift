//
//  UpdateInterestedInVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 25/12/21.
//

import UIKit

class UpdateInterestedInVC: UIViewController {
    
    @IBOutlet weak var vwMen: ViewCustom!
    @IBOutlet weak var imgMen: UIImageView!
    @IBOutlet weak var lblMen: UILabel!
    @IBOutlet weak var vwWomen: ViewCustom!
    @IBOutlet weak var imgWomen: UIImageView!
    @IBOutlet weak var lblWomen: UILabel!
    @IBOutlet weak var vwAll: ViewCustom!
    @IBOutlet weak var imgAll: UIImageView!
    @IBOutlet weak var lblAll: UILabel!
    
    var interestSelected : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if interestSelected == "1"{
            selectedInterestVw(selected: vwMen)
        }else if interestSelected == "2"{
            selectedInterestVw(selected: vwWomen)
        }else{
            selectedInterestVw(selected: vwAll)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnMenAction(_ sender: Any) {
        selectedInterestVw(selected: vwMen)
        interestSelected = "1"
    }
    
    @IBAction func btnWomenAction(_ sender: Any) {
        selectedInterestVw(selected: vwWomen)
        interestSelected = "2"
    }
    
    @IBAction func btnAllAction(_ sender: Any) {
        selectedInterestVw(selected: vwAll)
        interestSelected = "3"
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
       if interestSelected == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgInterestedIn, control: ["OK"], topController: self)
        }else{
            updateInterestedInProfile()
        }
    }

    func selectedInterestVw(selected:ViewCustom){
        
        let vws = [vwMen,vwWomen,vwAll]
        
        for vw in vws{
            
            if vw == selected{
                
                vw?.backgroundColor = UIColor(named: "appOrange")
                
                if selected == vwMen{
                    imgMen.image = UIImage(named: "male")
                    lblMen.textColor = .white
                }else if selected == vwWomen{
                    imgWomen.image = UIImage(named: "female")
                    lblWomen.textColor = .white
                }else if selected == vwAll{
                    imgAll.image = UIImage(named: "other")
                    lblAll.textColor = .white
                }
                
            }else{
                vw?.backgroundColor = .white
                vw?.borderColor = UIColor(named: "appOrange")
                
                if selected == vwMen{
                    
                    imgWomen.image = UIImage(named: "female2")
                    lblWomen.textColor = UIColor(named: "txtColor")
                    
                    imgAll.image = UIImage(named: "other2")
                    lblAll.textColor = UIColor(named: "txtColor")
                    
                }else if selected == vwWomen{
                    
                    imgMen.image = UIImage(named: "male2")
                    lblMen.textColor = UIColor(named: "txtColor")
                    
                    imgAll.image = UIImage(named: "other2")
                    lblAll.textColor = UIColor(named: "txtColor")
                    
                    
                }else if selected == vwAll{
                    
                    imgWomen.image = UIImage(named: "female2")
                    lblWomen.textColor = UIColor(named: "txtColor")
                    
                    imgMen.image = UIImage(named: "male2")
                    lblMen.textColor = UIColor(named: "txtColor")
                    
                    
                }
            }
        }
    }

}

//MARK: API
extension UpdateInterestedInVC{
    
    func updateInterestedInProfile(){
        
        UserVM.shared.updateProfile(keyName: "interestedIn", value: interestSelected) { [weak self] (success,msg) in
            
            if success{
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
