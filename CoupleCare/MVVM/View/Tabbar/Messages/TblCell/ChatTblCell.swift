//
//  ChatTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 08/03/22.
//

import UIKit

class ChatTblCell: UITableViewCell {

    //Sender
    @IBOutlet weak var lblSenderMsg: UILabel!
    @IBOutlet weak var lblSenderTime: UILabel!
    
    //Reciver
    @IBOutlet weak var lblRecieverTime: UILabel!
    @IBOutlet weak var lblRecieverMsg: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
