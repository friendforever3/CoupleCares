//
//  FeedVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedTblVw: UITableView!
    
    var page : Int = 1
    var lastCount : Int = 0
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
           refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh feed")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        feedTblVw.addSubview(refreshControl)
        
        feedTblVw.estimatedRowHeight = 600
        feedTblVw.rowHeight = UITableView.automaticDimension
        getAllFeed(page: page)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        refreshControl.beginRefreshing()
        page = 1
        getAllFeed(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnAddPostAction(_ sender: Any) {
        let vc = CreatePostVC.getVC(.Feed)
        vc.delegate = self
        self.push(vc)
    }
    
}

//MARK: FEED REFRESH DELEGATE
extension FeedVC:FeedRefreshDelegate{
    func didRefreshFeed() {
        getAllFeed(page: 1)
    }
    
    
    
}


//MARK: TABLEVIEW DELEGATE AND DATASOURCE
extension FeedVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedViewModel.shared.getFeedCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTblCell
        let feed = FeedViewModel.shared.getFeedPostDetail(indexPath: indexPath)
        let user = FeedViewModel.shared.getFeedUserDetail(indexPath: indexPath)
        UtilityManager.shared.setImage(image: cell.imgPost, urlString: feed.postImg)
        UtilityManager.shared.setImage(image: cell.imgUser, urlString: user.userImg)
        cell.lblUserName.text = user.userName
        cell.lblLocation.text = feed.postLoc
        cell.lblLikes.text = "\(feed.likeCount) Likes"
        cell.lblComments.text = "\(feed.commentCount) Comments"
        
        if feed.isPostLiked == true{
            cell.imgLike.image = UIImage(named: "heart")
        }else{
            cell.imgLike.image = UIImage(named: "love")
        }
        
        
        cell.lblText.attributedText = UtilityManager.shared.attributeText(sub: "\(user.userName) ", des: feed.postText, subSize: 17, desSize: 16, subFontName: "Lato-Bold", desFontName: "Lato-Regular")
        
        if feed.postType == "text"{
            cell.constraintHeightPostImg.constant = 0
        }else{
            cell.constraintHeightPostImg.constant = 414
        }
        
        cell.btnComment = {
            btn in
            
            let vc = CommentVC.getVC(.Feed)
            vc.postId = feed.postId
            vc.commentTo = user.userId
            vc.view.backgroundColor = .black.withAlphaComponent(0.5)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.view.backgroundColor = .black.withAlphaComponent(0.5)
            nav.setNavigationBarHidden(true, animated: false)
            self.present(nav, animated: true, completion: nil)
            
            
            
        }
        
        
        
        cell.btnLike = {
            
            btn in
            
            let vc = LikesVC.getVC(.Feed)
            vc.isLike = true
            vc.postId = feed.postId
            vc.view.backgroundColor = .black.withAlphaComponent(0.5)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.view.backgroundColor = .black.withAlphaComponent(0.5)
            nav.setNavigationBarHidden(true, animated: false)
            self.present(nav, animated: true, completion: nil)
            
        }
        
        cell.btnOption = {
            btn in
            
            let vc = LikesVC.getVC(.Feed)
            vc.isLike = false
            vc.view.backgroundColor = .black.withAlphaComponent(0.5)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.view.backgroundColor = .black.withAlphaComponent(0.5)
            nav.setNavigationBarHidden(true, animated: false)
            self.present(nav, animated: true, completion: nil)
        }
        
        
        cell.btnOpenOtherProfile = {
            btn in
            
            let vc = OtherProfileVC.getVC(.Home)
            vc.userId = user.userId
            self.push(vc)
            
        }
        
        cell.btnPostLike = { [weak self] btn in
            var type : String = ""
            if feed.isPostLiked == true{
                FeedViewModel.shared.setLike(indexPath: indexPath, isLike: false)
                type = "unlike"
            }else{
                FeedViewModel.shared.setLike(indexPath: indexPath, isLike: true)
                type = "like"
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self?.likeUnLikeApi(postId: feed.postId, likeTo: user.userId, type: type)
            }
            
            self?.feedTblVw.reloadData()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (FeedViewModel.shared.getFeedCount() - 1) == indexPath.row && self.lastCount != FeedViewModel.shared.getFeedCount(){
            page = page + 1
            getAllFeed(page: page)
            self.lastCount = FeedViewModel.shared.getFeedCount()
        }
    }
    
}

//MARK: GET ALL FEED
extension FeedVC{
    
    func getAllFeed(page:Int){
        FeedViewModel.shared.getFeedsList(page: page) { [weak self] (success,msg) in
            self?.refreshControl.endRefreshing()
            if success{
                print("total count:-",FeedViewModel.shared.getFeedCount())
                print("last count:-",self?.lastCount)
                
                print("FeedViewModel.shared.getFeedCount()-:",FeedViewModel.shared.getFeedCount())
                
                
                if self?.lastCount != FeedViewModel.shared.getFeedCount(){
                    self?.feedTblVw.reloadData()
                }
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func likeUnLikeApi(postId:String,likeTo:String,type:String){
        FeedViewModel.shared.likeUnlikeApi(postId: postId, likeTo: likeTo, type: type) { [weak self] (success,msg) in
            if success{
                self?.feedTblVw.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
