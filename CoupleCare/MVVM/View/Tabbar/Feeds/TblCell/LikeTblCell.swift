//
//  LikeTblCell.swift
//  CoupleCare
//
//  Created by Surinder kumar on 08/06/22.
//

import UIKit

class LikeTblCell: UITableViewCell {

    @IBOutlet weak var lbUserName: UILabel!
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
