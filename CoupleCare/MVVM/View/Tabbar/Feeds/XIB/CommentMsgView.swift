//
//  CommentMsgView.swift
//  CoupleCare
//
//  Created by Surinder kumar on 09/06/22.
//

import UIKit

class CommentMsgView: UIView {

    static var share: CommentMsgView? = nil
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    
    var btnReply : ((CommentMsgView)->Void)?
    var btnLikeComment : ((CommentMsgView)->Void)?
    
     static var instance: CommentMsgView {
         
         //if (share == nil) {
             share = Bundle(for: self).loadNibNamed("CommentMsgView",
                                                    owner: nil,
                                                    options: nil)?.first as? CommentMsgView
        // }
         return share!
     }
    @IBAction func btnReplyAction(_ sender: Any) {
        self.btnReply?(self)
    }
    
    @IBAction func btnLikeCmntAction(_ sender: Any) {
        self.btnLikeComment?(self)
    }
    
    
    
}
