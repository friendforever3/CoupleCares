//
//  CallModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/03/22.
//

import Foundation

class CallModel {
    
    var token : String = ""
    var videoGrant : String = ""
    
    func setData(dict:[String:Any]){
        token = dict["token"] as? String ?? ""
        videoGrant = dict["videoGrant"] as? String ?? ""
    }
    
}
