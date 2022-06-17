//
//  OTPVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class OTPVC: UIViewController {

    @IBOutlet weak var tfone: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThird: UITextField!
    @IBOutlet weak var tfForth: UITextField!
    @IBOutlet weak var tfFifth: UITextField!
    @IBOutlet weak var lblOtpMobile: UILabel!
    
    var otpString = String()
    
    var mobileNo : String = ""
    var dailCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.lblOtpMobile.text = "OTP send to \(dailCode)\(mobileNo)"
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        self.verifyOTP()
       //self.pushToName()
    }
    
    @IBAction func btnResendOtpAction(_ sender: Any) {
        self.resendOTP()
    }
    

}

//MARK:- textField Delegate
extension OTPVC: UITextFieldDelegate{
    
    func setDelegate(){
        let txtflds = [tfone,tfTwo,tfThird,tfForth,tfFifth]
        
        txtflds.forEach { txtfld in
            txtfld?.delegate = self
            txtfld?.keyboardType = .numberPad
        }
    
        self.tfone.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfTwo.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfThird.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfForth.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.tfFifth.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
       
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        otpString = ""
        if (text?.utf16.count)! >= 1{
            switch textField{
            case tfone:
                tfTwo.becomeFirstResponder()
            case tfTwo:
                tfThird.becomeFirstResponder()
            case tfThird:
                tfForth.becomeFirstResponder()
            case tfForth:
                tfFifth.becomeFirstResponder()
            case tfFifth:
                tfFifth.resignFirstResponder()
            
            default:
                break
            }
            otpString = "\(tfone.text ?? "")\(tfTwo.text ?? "")\(tfThird.text ?? "")\(tfForth.text ?? "")\(tfFifth.text ?? "" )"
        }
        if (text?.utf16.count)! == 0 {
            switch textField{
            case tfone:
                tfone.becomeFirstResponder()
            case tfTwo:
                tfone.becomeFirstResponder()
            case tfThird:
                tfTwo.becomeFirstResponder()
            case tfForth:
                tfThird.becomeFirstResponder()
            case tfFifth:
                tfForth.becomeFirstResponder()
            
            default:
                break
            }
            
        }else{
            
        }
    }
    
}


//MARK: API
extension OTPVC{
    
    func verifyOTP(){
        
        let otp = (tfone.text ?? "") + (tfTwo.text ?? "") + (tfThird.text ?? "") + (tfForth.text ?? "")
        
        UserViewModel.shared.verifyOTP(mobileNo: mobileNo, countryCode: dailCode, OTP: otp){ [weak self] (success, msg) in
            if success{
                
                if UtilityManager.shared.userDecodedDetail().isRegistered{
                    self?.pushToHome()
                }else{
                    self?.pushToName()
                }
            
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func resendOTP(){
        UserViewModel.shared.resendOTP(mobileNo: mobileNo, countryCode: dailCode) { [weak self] (success, msg) in
            if success{
                UtilityManager.shared.displayAlertWithCompletion(title: "", message: msg, control: ["OK"], topController: self ?? UIViewController()) { _ in
                }
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func pushToName(){
        let vc = NameVC.getVC(.Main)
        self.push(vc)
    }
    
    func pushToHome(){
        let vc = CoupleCaresTabbar.getVC(.CoupleCares)
        self.push(vc)
    }
    
}
