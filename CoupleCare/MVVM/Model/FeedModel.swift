//
//  FeedModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 28/05/22.
//

import Foundation

class FeedModel {
   
    var _id : String = ""
    var likes : Int = 0
    var comments : Int = 0
    var createdAt : String = ""
    var updatedAt : String = ""
    var userId : String = ""
    var isLike : Bool = false
    var post = PostModel()
    
    
    func setData(dict:[String:Any]){
        _id = dict["_id"] as? String ?? ""
        isLike = dict["isLike"] as? Bool ?? false
        if let post = dict["post"] as? [String:Any]{
            self.post.setData(dict:post)
        }
        
        
        
    }
    
}

class PostModel {

    var _id : String = ""
    var type : String = ""
    var like : Int = 0
    var comment : Int = 0
    var url : String = ""
    var text : String = ""
    var location : String = ""
    var caption : String = ""
    var createdAt : String = ""
    var updatedAt : String = ""
    var userId : String = ""
    var user = UserModel()
    
    func setData(dict:[String:Any]){
       
        _id = dict["_id"] as? String ?? ""
        type = dict["type"] as? String ?? ""
        like = dict["likes"] as? Int ?? 0
        comment = dict["comment"] as? Int ?? 0
        url = dict["url"] as? String ?? ""
        text = dict["text"] as? String ?? ""
        location = dict["location"] as? String ?? ""
        caption = dict["caption"] as? String ?? ""
        createdAt = dict["createdAt"] as? String ?? ""
        updatedAt = dict["updatedAt"] as? String ?? ""
        userId = dict["userId"] as? String ?? ""
        
        if let user = dict["user"] as? [String:Any]{
            self.user.setData(dict: user)
        }
    }
}



