//
//  FeedVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedTblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        feedTblVw.estimatedRowHeight = 600
        feedTblVw.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnAddPostAction(_ sender: Any) {
        let vc = CreatePostVC.getVC(.Feed)
        self.push(vc)
    }
    
}

extension FeedVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTblCell
        
        
        cell.btnComment = {
            btn in
            
            let vc = CommentVC.getVC(.Feed)
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
            self.push(vc)
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
