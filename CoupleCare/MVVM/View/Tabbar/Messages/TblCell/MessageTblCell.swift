//
//  MessageTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 06/03/22.
//

import UIKit

class MessageTblCell: UITableViewCell {

    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMsgTime: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
