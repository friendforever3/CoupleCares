//
//  InterestModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 14/12/21.
//

import Foundation

class InterestModel : Codable{
    
    var name : String = ""
    var _id : String = ""
    
    func setData(dict:[String:Any]){
        self.name = dict["name"] as? String ?? ""
        self._id = dict["_id"] as? String ?? ""
    }
    
}
