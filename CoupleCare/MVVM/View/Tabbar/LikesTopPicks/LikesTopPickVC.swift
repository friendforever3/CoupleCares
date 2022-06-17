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
    @IBOutlet weak var likeClcVw: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getAllLikeUser()
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
        if collectionView == likeClcVw{
            return LikesViewModel.shared.getAllUserLikedCount()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == likeClcVw{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LikeClcCell
            UtilityManager.shared.setImage(image: cell.imgLikeProfile, urlString: LikesViewModel.shared.getAllUserLikeCell(indexPath: indexPath).profileImgUrl)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OtherProfileVC.getVC(.Home)
        vc.userId = LikesViewModel.shared.getAllUserLikeCell(indexPath: indexPath).id
        vc.comingFrom = "like"
        self.push(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == likeClcVw{
            return CGSize(width: ((collectionView.frame.size.width) / 2) - 10, height: 212)
        }
        return CGSize(width: 0, height: 0)
    }
    
}


//MARK: Get All like User API
extension LikesTopPickVC{
    
    func getAllLikeUser(){
        
        LikesViewModel.shared.getAllLikesUser { [weak self] (success,msg) in
            if success{
                self?.likeClcVw.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
