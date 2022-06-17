//
//  UpdateBirthdayVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 25/12/21.
//

import UIKit

class UpdateBirthdayVC: UIViewController {
    
    @IBOutlet weak var tfDOB: TextFieldCustom!
    
    let datePicker = UIDatePicker()
    
    var age : String = ""
    var dob : String = ""
    var selectedDate : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showDatePicker()
        tfDOB.text = dob
        selectedDate = UtilityManager.shared.getDate(dateString:dob, inputDateformat: "dd/MM/yyyy", outputDateFormate: "yyyy-MM-dd")
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        if tfDOB.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgDOB, control: ["OK"], topController: self)
        }else{
            age = "\(calcAge(birthday: selectedDate))"
            updateBirthdayProfile()
        }
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
extension UpdateBirthdayVC{

func showDatePicker(){
    //Formate Date
    datePicker.datePickerMode = .date
    if #available(iOS 13.4, *) {
        datePicker.preferredDatePickerStyle = .wheels
    } else {
        // Fallback on earlier versions
    }
   //ToolBar
    self.datePicker.maximumDate = Date()
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
        selectedDate = formatter.string(from: datePicker.date)
        tfDOB.text = UtilityManager.shared.getDate(dateString: tfDOB.text ?? "", inputDateformat: "yyyy-MM-dd", outputDateFormate: "dd/MM/yyyy")
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

}

//MARK: API
extension UpdateBirthdayVC{
    
    func updateBirthdayProfile(){
        
        UserViewModel.shared.updateProfile2(keyName: "dob", value: selectedDate, keyName2: "age", value2: age) { [weak self] (success,msg) in
            
            if success{
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
