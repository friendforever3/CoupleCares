//
//  Indicator.swift
//  Gospel
//
//  Created by Surinder kumar on 21/09/21.
//

import Foundation
import NVActivityIndicatorView


class Indicator : UIViewController,NVActivityIndicatorViewable{
   static var shared = Indicator()
    let size = CGSize(width:35, height: 35)
    func start(_ msg : String){
        startAnimating(size, message: msg, messageFont: UIFont.systemFont(ofSize: 18), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor(named: "txtColor"), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1), textColor: .black)
    }
    
    func stop(){
        stopAnimating()
    }
    
}
