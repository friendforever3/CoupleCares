//
//  LikesVM.swift
//  CoupleCare
//
//  Created by Surinder kumar on 19/12/21.
//

import UIKit

class LikesVM: NSObject {
    
    public static let shared = LikesVM()
    
    var allLiked = [LikeModel]()
    
    private override init() {}
    
    
    func getAllLikesUser(completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kAllLikes, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    self?.allLiked.removeAll()
                    for elmnt in data{
                        let obj = LikeModel()
                        obj.setData(dict: elmnt)
                        self?.allLiked.append(obj)
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
    }
    
    
    func likeUser(likeUserId:String,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"likeId":likeUserId]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kLike, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func disLikeUser(likeUserId:String,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"dislikeId":likeUserId]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kDislike, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func acceptLikeUser(likedUserId:String,completion:@escaping completionHandler){
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"otherId":likedUserId,"timezone":UtilityManager.shared.getCurrentTimeZone()]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kAcceptProfile, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                let grpId = (response["data"] as? [String:Any])?["groupId"] as? String ?? ""
                completion(true,grpId)
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func superLikeProfile(likedUserId:String,completion:@escaping completionHandler){
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"otherId":likedUserId,"timezone":UtilityManager.shared.getCurrentTimeZone()]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kSuperLikeProfile, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: Get All Likes Data
    func getAllUserLikedCount()->Int{
        return allLiked.count
    }
    
    func getAllUserLikeCell(indexPath:IndexPath)->(id:String,profileImgUrl:String){
        return (id:allLiked[indexPath.row].objLikeId.likeId,profileImgUrl:allLiked[indexPath.row].objLikeId.profileImage)
    }

}
