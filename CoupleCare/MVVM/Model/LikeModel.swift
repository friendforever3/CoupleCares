//
//  LikeModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 19/12/21.
//

import Foundation

class LikeModel : Codable{
    var id : String = ""
    var objLikeId = LikeIdModel()
    
    func setData(dict:[String:Any]){
        id = dict["_id"] as? String ?? ""
        if let likeId = dict["likeId"] as? [String:Any]{
            objLikeId.setData(dict: likeId)
        }
    }
    
}

class LikeIdModel : Codable{
    var likeId : String = ""
    var profileImage : String = ""
    var images = [PhotoModel]()
    
    func setData(dict:[String:Any]){
        likeId = dict["_id"] as? String ?? ""
        profileImage = dict["profileImage"] as? String ?? ""
        if let photos = dict["images"] as? [[String:Any]]{
            self.images.removeAll()
            for elemnt in photos{
                let obj = PhotoModel()
                obj.setData(dict: elemnt)
                self.images.append(obj)
            }
        }
    }
}
