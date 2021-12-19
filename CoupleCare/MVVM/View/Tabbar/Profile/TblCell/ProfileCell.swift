//
//  ProfileCell.swift
//  CoupleCares
//
//  Created by Surinder kumar on 09/10/21.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblFeature: UILabel!
    
    @IBOutlet weak var lblProSetting: UILabel!
    
    @IBOutlet weak var photosClcVw: UICollectionView!
    
    @IBOutlet weak var interestClcVw: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
