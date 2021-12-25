//
//  UpdateInterestVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 25/12/21.
//

import UIKit

class UpdateInterestVC: UIViewController {

    @IBOutlet weak var interestClcVw: UICollectionView!
    
    var selectedIndexPath = [IndexPath]()
    
    var selectedIds = [InterestModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndexPath.removeAll()
        RegisterModel.shared.interests.removeAll()
        UserVM.shared.removeAllInterest()
        getAllInterest()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        
        if RegisterModel.shared.interests.count == 0{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgInterest, control: ["OK"], topController: self)
        }else{
           updateInterestProfile()
        }
        
    }

}

extension UpdateInterestVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserVM.shared.getInterestCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        
        if selectedIndexPath[indexPath.row] == indexPath{
            cell.backgroundColor = UIColor(named: "appOrange")
            cell.layer.cornerRadius = 24
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(named: "appOrange")?.cgColor
            cell.lblInterest.text = UserVM.shared.getInterestCellDetail(indexPath: indexPath).name
            cell.lblInterest.textColor = .white
        }else{
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 24
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(named: "appOrange")?.cgColor
            cell.lblInterest.text = UserVM.shared.getInterestCellDetail(indexPath: indexPath).name
            cell.lblInterest.textColor = UIColor(named: "txtColor")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedIndexPath[indexPath.row] == indexPath{
            let id = UserVM.shared.getInterestCellDetail(indexPath: indexPath).id
            RegisterModel.shared.interests.removeAll(where: {$0 == id})
            let index = IndexPath(row: -1, section: 0)
            selectedIndexPath[indexPath.row] = index
        }else{
           // if RegisterModel.shared.interests.count < 5{
                let id = UserVM.shared.getInterestCellDetail(indexPath: indexPath).id
                RegisterModel.shared.interests.append(id)
              selectedIndexPath[indexPath.row] = indexPath
           // }
        }
        
        interestClcVw.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = UserVM.shared.getInterestCellDetail(indexPath: indexPath).name
        label.sizeToFit()
        // return CGSize(width: (label.frame.width + 44), height: 48)
        return CGSize(width: ((interestClcVw.frame.size.width) / 3) - 10, height: 48)
    }
    
}

//MARK: API
extension UpdateInterestVC{
    
    func getAllInterest(){
        
        UserVM.shared.getListInterest { [weak self] (success,msg) in
            if success{
                
                
                for _ in 0...UserVM.shared.getInterestCount(){
                    let index = IndexPath(row: -1, section: 0)
                    self?.selectedIndexPath.append(index)
                }
                
                self?.checkselected()
            
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func checkselected(){
        
        for (index, value) in UserVM.shared.getAllInterest().enumerated(){
            for (index1,value1) in self.selectedIds.enumerated(){
                if value._id == value1._id{
                    let index2 = IndexPath(row: index, section: 0)
                    self.selectedIndexPath[index] = index2
                    RegisterModel.shared.interests.append(value._id)
                }
            }
        }
        self.interestClcVw.reloadData()
    }
}


//MARK: API
extension UpdateInterestVC{
    
    func updateInterestProfile(){
        
        UserVM.shared.updateInterestProfile(keyName: "interests", value: RegisterModel.shared.interests) { [weak self] (success,msg) in
            
            if success{
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
