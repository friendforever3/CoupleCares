//
//  OtherProfileVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class OtherProfileVC: UIViewController {

    @IBOutlet weak var vwPhotosHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clcPhotosVw: UICollectionView!
    @IBOutlet weak var vwInterestHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clcInterestVw: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        vwPhotosHeightConstraint.constant = 3 * ((((clcPhotosVw.frame.size.width) / 2) - 10) + 40)
       // vwInterestHeightConstraint.constant = 2 * 53
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
}


//MARK: CollectionView datasource and delegate
extension OtherProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clcPhotosVw{
            return 6
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clcPhotosVw{
            let vc = FullImageVC.getVC(.Home)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clcPhotosVw{
         return CGSize(width: ((clcPhotosVw.frame.size.width) / 2) - 10, height: (((clcPhotosVw.frame.size.width) / 2) - 10) + 31)
        }
        return CGSize(width: ((collectionView.frame.size.width) / 3) - 10, height: 48)
    }
    
}
