//
//  CommentVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit
import IQKeyboardManager
import SwiftUI

class CommentVC: UIViewController {

    @IBOutlet weak var vwChatBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblReplyuser: UILabel!
    @IBOutlet weak var vwReply: UIView!
    @IBOutlet weak var constraintHeightVwComment: NSLayoutConstraint!
    @IBOutlet weak var tfPost: IQTextView!
    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.estimatedRowHeight = 90
            tblVw.rowHeight = UITableView.automaticDimension
            tblVw.estimatedSectionHeaderHeight = 90
            tblVw.estimatedSectionHeaderHeight = UITableView.automaticDimension
        }
    }
    
    var postId : String = ""
    var page : Int = 1
    var lastCount : Int = 0
    var commentTo : String = ""
    var commentId : String = ""
    var replyTo : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getCommentList(page: page)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPostAction(_ sender: Any) {
        if !(vwReply.isHidden){
            if !(tfPost.text.isEmptyOrWhitespace()){
                postReplyComment(txt: tfPost.text ?? "", commtId: commentId, replyTo: replyTo)
            }
        }else{
            if !(tfPost.text.isEmptyOrWhitespace()){
                postComment(txt: tfPost.text ?? "")
            }
        }
    }
    
    @IBAction func btnCloseReplyAction(_ sender: Any) {
        vwReply.isHidden = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 2436:
                    vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    self.view.layoutIfNeeded()
                default:
                   
                    
                    if UIDevice.current.hasNotch
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    }
                    else
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height)
                    }
                    
                    
                    self.view.layoutIfNeeded()
                }
            }else if UIDevice().userInterfaceIdiom == .pad {
                switch UIScreen.main.nativeBounds.height {
                case 2436:
                    vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    self.view.layoutIfNeeded()
                default:
                    if UIDevice.current.hasNotch
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    }
                    else
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height)
                    }
                    
                    self.view.layoutIfNeeded()
                }
            }
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            vwChatBottomConstraint.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    
    
}

//MARK: TableView Delegate and Datasource

extension CommentVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FeedViewModel.shared.getCommentCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedViewModel.shared.getReplyCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath) as! ReplyTblCell
        cell.lblMsg.text = FeedViewModel.shared.getReplyDetail(indexPath: indexPath).msg
        cell.lblUserName.text = FeedViewModel.shared.getReplyDetail(indexPath: indexPath).name
        cell.lblMsgTime.text = FeedViewModel.shared.getReplyDetail(indexPath: indexPath).time
        cell.lblLikeCount.text = "\(FeedViewModel.shared.getReplyDetail(indexPath: indexPath).likeCount) like"
        UtilityManager.shared.setImage(image: cell.imgUser, urlString: FeedViewModel.shared.getReplyDetail(indexPath: indexPath).profileImg)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = CommentMsgView.instance
        vw.lblUserName.text = FeedViewModel.shared.getCommentDetail(section: section).name
        UtilityManager.shared.setImage(image: vw.imgUser, urlString: FeedViewModel.shared.getCommentDetail(section: section).profileImg)
        vw.lblMsg.text = FeedViewModel.shared.getCommentDetail(section: section).msg
        vw.lblTime.text = FeedViewModel.shared.getCommentDetail(section: section).time
        vw.lblLike.text = "\(FeedViewModel.shared.getCommentDetail(section: section).likeCount) like"
        
        vw.btnReply = { [weak self] (btn) in
            self?.commentId = FeedViewModel.shared.getCommentDetail(section: section).commentId
            self?.replyTo = FeedViewModel.shared.getCommentDetail(section: section).commentTo
            self?.vwReply.isHidden = false
            self?.lblReplyuser.text = "Replying to \(FeedViewModel.shared.getCommentDetail(section: section).name)"
        }
        
        vw.btnLikeComment = { [weak self] (btn) in
            print("FeedViewModel.shared.getCommentDetail(section: section).commentId:-",FeedViewModel.shared.getCommentDetail(section: section).commentId)
            self?.likeComment(commtId: FeedViewModel.shared.getCommentDetail(section: section).commentId, type: "like", likeUnlikeBy: UtilityManager.shared.userDecodedDetail().id, section: section)
        }
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    
}

//MARK: LIKE LIST
extension CommentVC{
 
    @objc func getCommentList(page:Int){
        FeedViewModel.shared.getCommentList(postId: postId, page: page) { [weak self] (success,msg) in
            if success{
                self?.tblVw.reloadData()
                self?.perform(#selector(self?.heightTbl), with: nil, afterDelay: 0.15)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func postComment(txt:String){
        FeedViewModel.shared.postComment(postId: postId, commentBy: UtilityManager.shared.userDecodedDetail().id, commentTo: commentTo, comment: txt) { [weak self] (success,msg) in
            if success{
                self?.getCommentList(page: 1)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func postReplyComment(txt:String,commtId:String,replyTo:String){
        FeedViewModel.shared.postReplyComment(commentId: commtId, replyBy: UtilityManager.shared.userDecodedDetail().id, replyTo: replyTo, reply: txt) { [weak self] (success,msg) in
            if success{
                self?.getCommentList(page: 1)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func likeComment(commtId:String,type:String,likeUnlikeBy:String,section:Int){
        FeedViewModel.shared.commentLike(commentId: commtId, type: type, likeUnlikeBy: likeUnlikeBy,section: section) { [weak self] (success,msg) in
            if success{
                self?.tblVw.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    
    @objc func heightTbl(){
        constraintHeightVwComment.constant = tblVw.contentSize.height + 60
    }
}
