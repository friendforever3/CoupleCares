//
//  BirthdayVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class BirthdayVC: UIViewController {

    @IBOutlet weak var tfDOB: TextFieldCustom!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showDatePicker()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if tfDOB.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgDOB, control: ["OK"], topController: self)
        }else{
            RegisterModel.shared.DOB = tfDOB.text ?? ""
            RegisterModel.shared.age = "\(calcAge(birthday: tfDOB.text ?? ""))"
            print("age:-",RegisterModel.shared.age)
            if RegisterModel.shared.age != ""{
                pushToGender()
            }
        }
    }
    
    func pushToGender(){
        let vc = GenderVC.getVC(.Main)
        self.push(vc)
    }
   
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate ?? Date(), to: now, options: [])
        let age = calcAge.year
        return age ?? 0
    }
    
}


//MARK: Datepicker
extension BirthdayVC{

func showDatePicker(){
    //Formate Date
    datePicker.datePickerMode = .date
    if #available(iOS 13.4, *) {
        datePicker.preferredDatePickerStyle = .wheels
    } else {
        // Fallback on earlier versions
    }
   //ToolBar
   let toolbar = UIToolbar();
   toolbar.sizeToFit()
   let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
  let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

 toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

    tfDOB.inputAccessoryView = toolbar
    tfDOB.inputView = datePicker

 }

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        tfDOB.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

}
