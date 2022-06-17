//
//  FeedTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class FeedTblCell: UITableViewCell {
    
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var constraintHeightPostImg: NSLayoutConstraint!
    
    
    var btnComment : ((FeedTblCell)->Void)?
    var btnLike : ((FeedTblCell)->Void)?
    var btnOption : ((FeedTblCell)->Void)?
    var btnOpenOtherProfile : ((FeedTblCell)->Void)?
    var btnPostLike : ((FeedTblCell)->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCommentAction(_ sender: Any) {
        self.btnComment?(self)
    }
    
    @IBAction func btnLikeAction(_ sender: Any) {
        self.btnLike?(self)
    }
    
    @IBAction func btnOptionAction(_ sender: Any) {
        self.btnOption?(self)
    }
    @IBAction func btnOpenOtherProfileAction(_ sender: Any) {
        self.btnOpenOtherProfile?(self)
    }
    
    @IBAction func btnPostLikeAction(_ sender: Any) {
        self.btnPostLike?(self)
    }
    
    
}
