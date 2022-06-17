//
//  CommentModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 08/06/22.
//

import Foundation

class CommentModel {

    var id : String = ""
    var like : Int = 0
    var likeUnlikeBy : String = ""
    var postId : String = ""
    var commentBy : String = ""
    var commentTo : String = ""
    var comment : String = ""
    var name : String = ""
    var profileImage : String = ""
    var replies = [ReplyModel]()
    var createdAt : String = ""
    
    func setData(dict:[String:Any]){
        id = dict["_id"] as? String ?? ""
        like = dict["like"] as? Int ?? 0
        likeUnlikeBy = dict["likeUnlikeBy"] as? String ?? ""
        postId = dict["postId"] as? String ?? ""
        commentBy = dict["commentBy"] as? String ?? ""
        commentTo = dict["commentTo"] as? String ?? ""
        comment = dict["comment"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        profileImage = dict["profileImage"] as? String ?? ""
       // replies = dict["replies"] as? String ?? ""
        createdAt = dict["createdAt"] as? String ?? ""
        self.replies.removeAll()
        if let replies = dict["replies"] as? [[String:Any]]{
            replies.forEach { [weak self] (obj) in
                let objReply = ReplyModel()
                objReply.setData(dict: obj)
                if !(self?.replies.contains(where: {$0.id == objReply.id}) ??  false){
                    self?.replies.append(objReply)
                }
            }
        }
        
    }
     
}


class ReplyModel{
   
    var like : Int = 0
    var createdAt : String = ""
    var id : String = ""
    var replyBy : String = ""
    var replyTo : String = ""
    var reply : String = ""
    var name : String = ""
    var profileImage : String = ""
    
    func setData(dict:[String:Any]){
        like = dict["like"] as? Int ?? 0
        id = dict["_id"] as? String ?? ""
        createdAt = dict["createdAt"] as? String ?? ""
        replyBy = dict["replyBy"] as? String ?? ""
        replyTo = dict["replyTo"] as? String ?? ""
        reply = dict["reply"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        profileImage = dict["profileImage"] as? String ?? ""
    }
    
}
