//
//  MessageModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 06/03/22.
//

import Foundation

class MessageModel {
    
    var _id : String = ""
    var otherfullName : String = ""
    var profileImage : String = ""
    var other_id : String = ""
    var userId : String = ""
    var createdAt : String = ""
    var day : String = ""
    var groupId : String = ""
    var msg : String = ""
    var time : String = ""
    var updatedAt : String = ""
    
    func setData(dict:[String:Any]){
        _id = dict["_id"] as? String ?? ""
        if let otherId = dict["otherId"] as? [String:Any]{
            otherfullName = otherId["fullName"] as? String ?? ""
            profileImage = otherId["profileImage"] as? String ?? ""
            other_id = otherId["_id"] as? String ?? ""
        }
        userId = dict["userId"] as? String ?? ""
        createdAt = dict["createdAt"] as? String ?? ""
        day = dict["day"] as? String ?? ""
        groupId = dict["groupId"] as? String ?? ""
        msg = dict["msg"] as? String ?? ""
        time = dict["time"] as? String ?? ""
    }
    
}

class ChatModel {
    
    var _id : String = ""
    var groupId : String = ""
    var receiverId : String = ""
    var senderId : String = ""
    var username : String = ""
    var profileImage : String = ""
    var time : String = ""
    var day : String = ""
    var msg : String = ""
    var createdAt : String = ""
    
    func setData(dict:[String:Any]){
        _id = dict["_id"] as? String ?? ""
        groupId = dict["groupId"] as? String ?? ""
        receiverId = dict["receiverId"] as? String ?? ""
        senderId = dict["senderId"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        profileImage = dict["profileImage"] as? String ?? ""
        time = dict["time"] as? String ?? ""
        day = dict["day"] as? String ?? ""
        msg = dict["msg"] as? String ?? ""
        createdAt = dict["createdAt"] as? String ?? ""
    }
    
}
