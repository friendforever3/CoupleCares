//
//  FeedTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class FeedTblCell: UITableViewCell {
    
    
    var btnComment : ((FeedTblCell)->Void)?
    var btnLike : ((FeedTblCell)->Void)?
    var btnOption : ((FeedTblCell)->Void)?

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
    
}
