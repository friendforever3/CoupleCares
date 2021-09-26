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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension InterestsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 24
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "appOrange")?.cgColor
        cell.lblInterest.text = textArray[indexPath.item]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.text = textArray[indexPath.item]
            label.sizeToFit()
           // return CGSize(width: (label.frame.width + 44), height: 48)
        return CGSize(width: ((interestClcVw.frame.size.width) / 3) - 10, height: 48)
        }
    
}
