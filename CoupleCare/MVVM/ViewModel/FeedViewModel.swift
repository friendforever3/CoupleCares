//
//  FeedViewModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 28/05/22.
//

import UIKit

class FeedViewModel: NSObject {

    public static let shared = FeedViewModel()
    private var feedArray = [FeedModel]()
    private var likeArray = [UserModel]()
    private var commentarray = [CommentModel]()
    private override init() {}
    
    //MARK: CREATE POST OR FEED API
    func createFeed(userid:String,type:String,text:String,location:String,caption:String,fileData:Data?,completion:@escaping completionHandler){
        let param = ["userId":userid,"type":type,"text":text,"location":location,"caption":caption]
        uploadDataToServerHandler(url: APIConstant.kBaseUrl + APIConstant.kPostCreate, param: param, imgData: [fileData ?? Data()], fileName: "file") { [weak self] (response) in
            if response?["statusCode"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }

    }
    
    
    //MARK: GET ALL FEED
    func getFeedsList(page:Int,completion:@escaping completionHandler){
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"page":"\(page)","size":"100"]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kFeedList, param: param, method: .post, header: nil) { [weak self] (response, statusCode,errorMsg) in
            page == 1 ? self?.feedArray.removeAll() : nil
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [String:Any]{
                    if let feeds = data["feeds"] as? [[String:Any]]{
                        feeds.forEach { (obj) in
                            let objPost = FeedModel()
                            objPost.setData(dict: obj)
                            if !(self?.feedArray.contains(where: {$0._id == objPost._id}) ?? false){
                                self?.feedArray.append(objPost)
                            }
                        }
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: LIKE AND UNLIKE API
    func likeUnlikeApi(postId:String,likeTo:String,type:String,completion:@escaping completionHandler){
        let param = ["postId":postId,"likeBy":UtilityManager.shared.userDecodedDetail().id,"likeTo":likeTo,"type":type]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kLikeUnlikePost, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: GET LIKE LIST
    func getLikeList(postId:String,page:Int,completion:@escaping completionHandler){
        let param = ["postId":postId,"page":page,"size":100] as [String : Any]
        page == 1 ? likeArray.removeAll() : nil
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kLikeListPost, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    data.forEach { [weak self] (dataObj) in
                        let obj = UserModel()
                        obj.setData(dict: dataObj)
                        if !(self?.likeArray.contains(where: {$0.id == obj.id}) ?? false){
                            self?.likeArray.append(obj)
                        }
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
        
    }
    
    
    //MARK: GET COMMENT LIST
    func getCommentList(postId:String,page:Int,completion:@escaping completionHandler){
        let param = ["postId":postId,"page":page,"size":100] as [String : Any]
        page == 1 ? commentarray.removeAll() : nil
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kCommentList, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    data.forEach { [weak self] (dataObj) in
                        let obj = CommentModel()
                        obj.setData(dict: dataObj)
                        if !(self?.commentarray.contains(where: {$0.id == obj.id}) ?? false){
                            self?.commentarray.append(obj)
                        }
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: POST COMMENT
    func postComment(postId:String,commentBy:String,commentTo:String,comment:String,completion:@escaping completionHandler){
        let param = ["postId":postId,"commentBy":commentBy,"commentTo":commentTo,"comment":comment]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kCommentAdd, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: POST REPLY COMMENT
    func postReplyComment(commentId:String,replyBy:String,replyTo:String,reply:String,completion:@escaping completionHandler){
        let param = ["commentId":commentId,"replyBy":replyBy,"replyTo":replyTo,"reply":reply]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kcommentAddReply, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: Like COMMENT
    func commentLike(commentId:String,type:String,likeUnlikeBy:String,section:Int,completion:@escaping completionHandler){
        let param = ["commentId":commentId,"type":type,"likeUnlikeBy":likeUnlikeBy]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kCommentReplyLikeUnlike, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if type == "like"{
                    self?.commentarray[section].like = (self?.commentarray[section].like ?? 0) + 1
                }else{
                    if self?.commentarray[section].like != 0{
                        self?.commentarray[section].like = (self?.commentarray[section].like ?? 0) - 1
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    
    //MARK: GET FEED DETAIL
    func getFeedCount()->Int{
        return feedArray.count
    }
    
    func getFeedUserDetail(indexPath:IndexPath)->(userId:String,userName:String,userLocation:String,userImg:String){
        return (userId:feedArray[indexPath.row].post.user.id,userName:feedArray[indexPath.row].post.user.fullName,userLocation:"",userImg:feedArray[indexPath.row].post.user.profileImage)
    }
    
    func getFeedPostDetail(indexPath:IndexPath)->(postImg:String,likeCount:Int,commentCount:Int,postId:String,postLoc:String,postText:String,postType:String,isPostLiked:Bool){
        
        let img = feedArray[indexPath.row].post.url
        print("image:-",img)
        let likes = feedArray[indexPath.row].post.like
        let comments = feedArray[indexPath.row].post.comment
        let pstId = feedArray[indexPath.row].post._id
        let postloc  = feedArray[indexPath.row].post.location
        let txt  = feedArray[indexPath.row].post.caption
        let type  = feedArray[indexPath.row].post.type
        print("type:-",type)
        let postLike = feedArray[indexPath.row].isLike
        
        return (postImg:img,likeCount:likes,commentCount:comments,postId:pstId,postLoc:postloc,postText:txt,postType:type,isPostLiked:postLike)
        
    }
    
    func setLike(indexPath:IndexPath,isLike:Bool){
        if isLike == true{
            feedArray[indexPath.row].post.like = feedArray[indexPath.row].post.like + 1
        }else{
            if feedArray[indexPath.row].post.like > 0{
                feedArray[indexPath.row].post.like = feedArray[indexPath.row].post.like - 1
            }else{
                feedArray[indexPath.row].post.like = 0
            }
        }
        feedArray[indexPath.row].isLike = isLike
    }
    
    
    //MARK: LIKE DATA
    func getLikeUserCount()->Int{
        return likeArray.count
    }
    
    func getLikeUserDetail(indexPath:IndexPath)->(id:String,profileImg:String,name:String){
        
        return (id:likeArray[indexPath.row].id,profileImg:likeArray[indexPath.row].profileImage,name:likeArray[indexPath.row].name)
    }
    
    //MARK: COMMENT DATA
    func getCommentCount()->Int{
        return commentarray.count
    }
    
    func getCommentDetail(section:Int)->(name:String,msg:String,time:String,likeCount:Int,profileImg:String,commentId:String,commentTo:String){
        
        let name = commentarray[section].name
        let comment = commentarray[section].comment
        let time = "4h"//commentarray[section].createdAt
        let likeCnt = commentarray[section].like
        let img = commentarray[section].profileImage
        let comntId = commentarray[section].id
        let cmntTo = commentarray[section].commentTo
        return (name:name,msg:comment,time:time,likeCount:likeCnt,profileImg:img,commentId:comntId,commentTo:cmntTo)
    }
    
    func getReplyCount(section:Int)->Int{
        return commentarray[section].replies.count
    }
    
    func getReplyDetail(indexPath:IndexPath)->(name:String,msg:String,time:String,likeCount:Int,profileImg:String,replyId:String){
        let name = commentarray[indexPath.section].replies[indexPath.row].name
        let comment = commentarray[indexPath.section].replies[indexPath.row].reply
        let time = "4h"//commentarray[section].createdAt
        let likeCnt = commentarray[indexPath.section].replies[indexPath.row].like
        let img = commentarray[indexPath.section].replies[indexPath.row].profileImage
        let comntId = commentarray[indexPath.section].replies[indexPath.row].id
        
        return (name:name,msg:comment,time:time,likeCount:likeCnt,profileImg:img,replyId:comntId)
    }
    
    
    
}
