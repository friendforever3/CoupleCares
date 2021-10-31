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
    
    var otpString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegate()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        let vc = NameVC.getVC(.Main)
        self.push(vc)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
