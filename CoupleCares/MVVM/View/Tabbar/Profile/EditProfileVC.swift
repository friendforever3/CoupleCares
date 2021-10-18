//
//  EditProfileVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 09/10/21.
//

import UIKit

class EditProfileVC: UIViewController {

    
    let objectArray = [["type":"clc","value":""],["type":"Bio","value":"Lorem ipsum dolor sit amet, consectetur"],["type":"clc","value":""],["type":"Gender","value":"Male"],["type":"Job Title","value":"Musician"],["type":"Your Location","value":"LA"],["type":"Interested In","value":"Women"],["type":"Birthday","value":"12/03/1995"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
}

//MARK: Tableview Delegate and Datsource
extension EditProfileVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! ProfileCell
            cell.lblType.text = objectArray[indexPath.row]["type"]
            cell.lblValue.text = objectArray[indexPath.row]["value"]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else if indexPath.row == 2{
            return 120
        }else{
            return UITableView.automaticDimension
        }
    }
    
}

//MARK: CollectionView datasource and delegate
extension EditProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return 6
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
         return CGSize(width: ((collectionView.frame.size.width) / 3) - 10, height: 132)
        }
        return CGSize(width: ((collectionView.frame.size.width) / 3) - 10, height: 48)
    }
    
}
