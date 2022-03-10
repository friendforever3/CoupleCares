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
    @IBOutlet weak var vwInitial: UIView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserNameAge: UILabel!
    @IBOutlet weak var lblLocName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblJob: UILabel!
    
    var delegate : didUpdateDelegate?
    var userId : String = ""
    var comingFrom : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if comingFrom == "like"{
            getLikeUserDetail()
        }else{
           getUserDetail()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
       // vwInterestHeightConstraint.constant = 2 * 53
    }
    
    func setUI(){
        
        UtilityManager.shared.setImage(image: self.imgProfile, urlString: HomeVM.shared.getUserDetailData().profileImg)
        lblUserNameAge.text = "\(HomeVM.shared.getUserDetailData().fullName), \(HomeVM.shared.getUserDetailData().age)"
        lblDistance.text = "\((Double(HomeVM.shared.getUserDetailData().distance) ?? 0.0).roundToDecimal(2))" + " " + "Miles"
        lblBio.text = HomeVM.shared.getUserDetailData().bio
        lblJob.text = HomeVM.shared.getUserDetailData().job
        self.vwInitial.isHidden = true
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnLikeAction(_ sender: Any) {
        if comingFrom == "like"{
            acceptUserProfile(likeUserId: userId)
        }else{
            userDislike(likeUserId: userId)
        }
    }
    
    @IBAction func btnDislikeAction(_ sender: Any) {
        if comingFrom == "like"{
        }else{
            userLike(likeUserId: userId)
        }
    }
    
}


//MARK: CollectionView datasource and delegate
extension OtherProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clcPhotosVw{
            return HomeVM.shared.getUserDetailPhotosCount()
        }
        return HomeVM.shared.getUserDetailInterestCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        
        if collectionView == clcPhotosVw{
            UtilityManager.shared.setImage(image: cell.lblUserDetailPhoto, urlString: HomeVM.shared.getUserDetailPhotoCell(indexPath: indexPath).imgUrl)
        }else{
            cell.lblInterest.text = HomeVM.shared.getUserDetailInterestCell(indexPath: indexPath)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clcPhotosVw{
            let vc = FullImageVC.getVC(.Home)
            vc.imgUrl = HomeVM.shared.getUserDetailPhotoCell(indexPath: indexPath).imgUrl
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


//MARK: User Detail Api
extension OtherProfileVC {
    
    func getUserDetail(){
        
        HomeVM.shared.userDetail(userId: userId) { [weak self] (success,msg) in
            if success{
                self?.setUI()
                self?.clcPhotosVw.reloadData()
                self?.clcInterestVw.reloadData()
                
                self?.getHeight()
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
        
    }
    
    
    func getLikeUserDetail(){
        HomeVM.shared.likeProfile(likeId: userId) { [weak self] (success,msg) in
            if success{
                self?.setUI()
                self?.clcPhotosVw.reloadData()
                self?.clcInterestVw.reloadData()
                
                self?.getHeight()
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func getHeight(){
        let count = HomeVM.shared.getUserDetailPhotosCount() % 2
        
        let divide = HomeVM.shared.getUserDetailPhotosCount() / 2
        
        if count == 0{
            let counttotl : CGFloat = CGFloat(divide)
            self.vwPhotosHeightConstraint.constant = counttotl * ((((self.clcPhotosVw.frame.size.width) / 2) - 10) + 40)
        }else{
            let counttotl : CGFloat = CGFloat(divide + 1)
            print("")
            self.vwPhotosHeightConstraint.constant = counttotl * ((((self.clcPhotosVw.frame.size.width) / 2) - 10) + 40)
        }
        
        self.getInterestHeight()
    }
    
    func getInterestHeight(){
        
        let count = HomeVM.shared.getUserDetailInterestCount() % 3
        
        let divide = HomeVM.shared.getUserDetailInterestCount() / 3
        print("divide:-",divide)
        print("countL-",count)
        if count == 0{
            let counttotl : CGFloat = CGFloat(divide)
            self.vwInterestHeightConstraint.constant = counttotl * 55
        }else{
            let counttotl : CGFloat = CGFloat(divide + 1)
            self.vwInterestHeightConstraint.constant = counttotl * 55
        }
        
        print("self.vwInterestHeightConstraint.constant:-",self.vwInterestHeightConstraint.constant)
    }
    
}


//MARK: API
extension OtherProfileVC{
    
    func userLike(likeUserId:String){
        LikesVM.shared.likeUser(likeUserId: likeUserId) { [weak self] (success,msg) in
            if success{
                self?.delegate?.didUpdateHome()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func userDislike(likeUserId:String){
        LikesVM.shared.disLikeUser(likeUserId: likeUserId) { [weak self] (success,msg) in
            if success{
                self?.delegate?.didUpdateHome()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func acceptUserProfile(likeUserId:String){
        LikesVM.shared.acceptLikeUser(likedUserId: likeUserId) { [weak self] (success,msg) in
            if success{
                let vc = ChatVC.getVC(.Message)
                vc.otherUserId = likeUserId
                vc.grpId = msg
                vc.otherImgurl = HomeVM.shared.getUserDetailData().profileImg
                vc.otherUserName = HomeVM.shared.getUserDetailData().fullName
                self?.push(vc)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
