//
//  GenderVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class GenderVC: UIViewController {

    @IBOutlet weak var vwMale: ViewCustom!
    @IBOutlet weak var imgMale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var vwFemale: ViewCustom!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var lblFemale: UILabel!
    @IBOutlet weak var vwOther: ViewCustom!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var lblOther: UILabel!
    
    @IBOutlet weak var vwMen: ViewCustom!
    @IBOutlet weak var imgMen: UIImageView!
    @IBOutlet weak var lblMen: UILabel!
    @IBOutlet weak var vwWomen: ViewCustom!
    @IBOutlet weak var imgWomen: UIImageView!
    @IBOutlet weak var lblWomen: UILabel!
    @IBOutlet weak var vwAll: ViewCustom!
    @IBOutlet weak var imgAll: UIImageView!
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblHeaderInterest: UILabel!
    @IBOutlet weak var vwProfileCompleteHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwInterestHeightConstraint: NSLayoutConstraint!
    
    
    var genderSelected : String = ""
    var interestSelected : String = ""
    var isComingfrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if genderSelected == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgGender, control: ["OK"], topController: self)
        }else if interestSelected == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgInterestedIn, control: ["OK"], topController: self)
        }else{
            RegisterModel.shared.gender = genderSelected
            RegisterModel.shared.interestedIn = interestSelected
            pushToInterest()
        }
    }
    
    //1 == male 2 == female 3 == other
    func pushToInterest(){
        let vc = InterestsVC.getVC(.Main)
        self.push(vc)
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
    //1 == male 2 == female 3 == all
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

