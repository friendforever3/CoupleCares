//
//  PhotoVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class PhotoVC: UIViewController {

    @IBOutlet weak var vwPhotoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoClcVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwPhotoHeightConstraint.constant = 275
    }
    

}


extension PhotoVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: ((photoClcVw.frame.size.width) / 3) - 10, height: 132)
        }
    
}
