//
//  LikesTopPickVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class LikesTopPickVC: UIViewController {

    @IBOutlet weak var vwPick: UIView!
    @IBOutlet weak var vwLikes: UIView!
    @IBOutlet weak var vwScroll: UIScrollView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblPick: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLikesAction(_ sender: Any) {
        vwLikes.backgroundColor = UIColor(named: "appOrange")
        vwPick.backgroundColor = UIColor.white
        vwScroll.scrollTo(horizontalPage: 0, verticalPage: 0, animated: true)
        lblLike.textColor = .white
        lblPick.textColor = UIColor(named: "headerTxtColor")
    }
    
    @IBAction func btnPickAction(_ sender: Any) {
        vwPick.backgroundColor = UIColor(named: "appOrange")
        vwLikes.backgroundColor = UIColor.white
        vwScroll.scrollTo(horizontalPage: 1, verticalPage: 0, animated: true)
        lblPick.textColor = .white
        lblLike.textColor = UIColor(named: "headerTxtColor")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(vwScroll.currentPage)
        if vwScroll.currentPage == 1{
            vwLikes.backgroundColor = UIColor(named: "appOrange")
            vwPick.backgroundColor = UIColor.white
            vwScroll.scrollTo(horizontalPage: 0, verticalPage: 0, animated: true)
            lblLike.textColor = .white
            lblPick.textColor = UIColor(named: "headerTxtColor")
        }else{
            vwPick.backgroundColor = UIColor(named: "appOrange")
            vwLikes.backgroundColor = UIColor.white
            vwScroll.scrollTo(horizontalPage: 1, verticalPage: 0, animated: true)
            lblPick.textColor = .white
            lblLike.textColor = UIColor(named: "headerTxtColor")
        }
    }
    
}

extension LikesTopPickVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: ((collectionView.frame.size.width) / 2) - 10, height: 212)
        }
    
}
