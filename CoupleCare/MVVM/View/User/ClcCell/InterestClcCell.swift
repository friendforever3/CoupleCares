//
//  InterestClcCell.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit

class InterestClcCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAddIcon: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnDeleteImg: UIButton!
    @IBOutlet weak var lblInterest: UILabel!
    
    @IBOutlet weak var lblHomeInterest: UILabel!
    
    @IBOutlet weak var lblUserDetailPhoto: ImageCustom!
    
    
    @IBOutlet weak var imgProfileImages: UIImageView!
    @IBOutlet weak var btnProfileDelete: UIButton!
    @IBOutlet weak var imgProfileAddIcon: UIImageView!
    var btnProfileDelt : ((InterestClcCell)->Void)?
    
    var imgDelete : ((InterestClcCell)->Void)?
    
    @IBAction func btnDeleteImgAction(_ sender: Any) {
        self.imgDelete?(self)
    }
    
    @IBAction func btnProfileDeleteAction(_ sender: Any) {
        self.btnProfileDelt?(self)
    }
    
    
}
