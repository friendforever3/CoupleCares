//
//  CallView.swift
//  CoupleCare
//
//  Created by Surinder kumar on 29/03/22.
//

import UIKit

class CallView: UIView {

    static var share: CallView? = nil
     static var instance: CallView {
         
         if (share == nil) {
             share = Bundle(for: self).loadNibNamed("CallView",
                                                    owner: nil,
                                                    options: nil)?.first as? CallView
         }
         return share!
     }
    
    
    func show() {
        
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.frame)!
        window?.addSubview(self)
        
        self.alpha = 0.0
        UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0, options: .curveEaseIn) {
            self.alpha = 1.0
        } completion: { (_) in
            
        }
    }
    
    func removeAlert() {
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.frame)!
        window?.removeFromSuperview()
        self.removeFromSuperview()
        
    }

    
    @IBAction func btnAcceptAction(_ sender: Any) {
    }
    @IBAction func btnDeclineAction(_ sender: Any) {
    }
    
}
