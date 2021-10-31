//
//  InterestsVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class InterestsVC: UIViewController {

    @IBOutlet weak var interestClcVw: UICollectionView!
    
    let textArray = ["Craft","Comedy","Cars","Cooking","Cycling","Dancing","Pets","Travelling","Singing"]
    
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        let vc = PhotoVC.getVC(.Main)
        self.push(vc)
    }
    
}

extension InterestsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        
        if selectedIndexPath == indexPath{
            cell.backgroundColor = UIColor(named: "appOrange")
            cell.layer.cornerRadius = 24
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(named: "appOrange")?.cgColor
            cell.lblInterest.text = textArray[indexPath.item]
            cell.lblInterest.textColor = .white
        }else{
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 24
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "appOrange")?.cgColor
        cell.lblInterest.text = textArray[indexPath.item]
            cell.lblInterest.textColor = UIColor(named: "txtColor")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        interestClcVw.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = textArray[indexPath.item]
        label.sizeToFit()
        // return CGSize(width: (label.frame.width + 44), height: 48)
        return CGSize(width: ((interestClcVw.frame.size.width) / 3) - 10, height: 48)
    }
    
}
