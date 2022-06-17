//
//  LikesVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class LikesVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var vwReport: UIView!
    @IBOutlet weak var constraintHeightVwLike: NSLayoutConstraint!
    
    var isLike : Bool = false
    var postId : String = ""
    var page : Int = 1
    var lastCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getListUser(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLike{
            vwMenu.isHidden = false
            vwReport.isHidden = true
        }else{
            vwMenu.isHidden = true
            vwReport.isHidden = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        self.vwReport.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
   
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: TableView Delegate and Datasource

extension LikesVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedViewModel.shared.getLikeUserCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath) as! LikeTblCell
        cell.lbUserName.text = FeedViewModel.shared.getLikeUserDetail(indexPath: indexPath).name
        UtilityManager.shared.setImage(image: cell.imgUser, urlString: FeedViewModel.shared.getLikeUserDetail(indexPath: indexPath).profileImg)
        print("self.tblVw.contentSize.height:- ",self.tblVw.contentSize.height)
        constraintHeightVwLike.constant = self.tblVw.contentSize.height + 100
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (FeedViewModel.shared.getLikeUserCount() - 1) == indexPath.row && self.lastCount != FeedViewModel.shared.getLikeUserCount(){
        page = page + 1
            getListUser(page: page)
            lastCount = FeedViewModel.shared.getLikeUserCount()
        }
    }
    
    
}

//MARK: LIKE LIST
extension LikesVC{
    
    func getListUser(page:Int){
        FeedViewModel.shared.getLikeList(postId: postId, page: page) { [weak self] (success,msg) in
            if success{
               
                if self?.lastCount != FeedViewModel.shared.getFeedCount(){
                    self?.tblVw.reloadData()
                }
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
