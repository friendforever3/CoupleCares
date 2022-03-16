//
//  InterestsVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class InterestsVC: UIViewController {

    @IBOutlet weak var interestClcVw: UICollectionView!
    
    var selectedIndexPath = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        RegisterModel.shared.interests.removeAll()
        getAllInterest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        
        if RegisterModel.shared.interests.count == 0{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgInterest, control: ["OK"], topController: self)
        }else{
            pushToPhotos()
        }
        
    }
    
    func pushToPhotos(){
        let vc = PhotoVC.getVC(.Main)
        self.push(vc)
    }
    
}

extension InterestsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
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
            //}
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
extension InterestsVC{
    
    func getAllInterest(){
        
        UserVM.shared.getListInterest { [weak self] (success,msg) in
            if success{
                self?.interestClcVw.reloadData()
                
                for _ in 0...UserVM.shared.getInterestCount(){
                    let index = IndexPath(row: -1, section: 0)
                    self?.selectedIndexPath.append(index)
                }
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
    
}
