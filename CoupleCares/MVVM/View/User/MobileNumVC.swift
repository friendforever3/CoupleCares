//
//  MobileNumVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit
import CountryPicker

class MobileNumVC: UIViewController {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var tfCode: TextFieldCustom!
    
    let picker = CountryPicker()
    
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
        
        
        tfCode.inputView = picker
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        let vc = OTPVC.getVC(.Main)
        self.push(vc)
    }
    
   

}

//MARK: Country Picker
extension MobileNumVC : CountryPickerDelegate{
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        imgFlag.image = flag
    }
    
}
