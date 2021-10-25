//
//  SettingView.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class SettingView: UIView {

    static var share: SettingView? = nil
     static var instance: SettingView {
         
         if (share == nil) {
             share = Bundle(for: self).loadNibNamed("SettingView",
                                                    owner: nil,
                                                    options: nil)?.first as? SettingView
         }
         return share!
     }
}
