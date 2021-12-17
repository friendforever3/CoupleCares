//
//  MobileNumVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit
import CountryPicker
import CoreTelephony

class MobileNumVC: UIViewController {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var tfCode: TextFieldCustom!
    @IBOutlet weak var tfMobileNo: TextFieldCustom!
    
    let picker = CountryPicker()
    var countryCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
        picker.theme = theme //optional for UIPickerView theme changes
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)
        //countryCode = code ?? ""
        
        tfCode.inputView = picker
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if tfMobileNo.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgFullName, control: ["OK"], topController: self)
        }else{
            sendMobileOTP()
           // pushToOtp()
        }
    }
    
}

//MARK: Country Picker
extension MobileNumVC : CountryPickerDelegate{
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        imgFlag.image = flag
        self.countryCode = phoneCode
    }
}


//MARK: API
extension MobileNumVC{
    
    func sendMobileOTP(){
        UserVM.shared.sendMobileOTP(mobileNo: tfMobileNo.text ?? "", countryCode: self.countryCode) { [weak self] (success, msg) in
            if success{
                UtilityManager.shared.displayAlertWithCompletion(title: "", message: msg, control: ["OK"], topController: self ?? UIViewController()) { _ in
                    RegisterModel.shared.mobileNo = self?.tfMobileNo.text ?? ""
                    RegisterModel.shared.dailCode = self?.countryCode ?? ""
                    self?.pushToOtp()
                }
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func pushToOtp(){
        let vc = OTPVC.getVC(.Main)
        vc.mobileNo = tfMobileNo.text ?? ""
        vc.dailCode = countryCode
        self.push(vc)
    }
    
}
