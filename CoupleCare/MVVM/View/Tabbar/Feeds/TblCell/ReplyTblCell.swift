//
//  ReplyTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 17/06/22.
//

import UIKit

class ReplyTblCell: UITableViewCell {

    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblMsgTime: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: ImageCustom!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
