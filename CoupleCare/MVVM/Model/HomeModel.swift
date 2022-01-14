//
//  HomeModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 18/12/21.
//

import Foundation


class HomeModel : Codable{
    var id : String = ""
    var name : String = ""
    var age : Int = 0
    var profileImage : String = ""
    var locDistance : String = ""
    var interestArray = [InterestModel]()
    var coordinates = CoordinateModel()
    
    func setData(dict:[String:Any]){
        id = dict["_id"] as? String ?? ""
        name = dict["fullName"] as? String ?? ""
        profileImage = dict["profileImage"] as? String ?? ""
        age = dict["age"] as? Int ?? 0
        self.interestArray.removeAll()
        if let interests = dict["interests"] as? [[String:Any]]{
            for elemnt in interests{
                let obj = InterestModel()
                obj.setData(dict: elemnt)
                self.interestArray.append(obj)
            }
        }
        
        if let coordinate = dict["coordinates"] as? [String:Any]{
            coordinates.setData(dict: coordinate)
        }
    }

}


class CoordinateModel : Codable{
    
    var lat : String = ""
    var long : String = ""
    
    func setData(dict:[String:Any]){
        self.lat = dict["lat"] as? String ?? ""
        self.long = dict["lng"] as? String ?? ""
    }
    
}
