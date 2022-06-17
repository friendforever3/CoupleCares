//
//  TwilioViewModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/03/22.
//

import UIKit

class TwilioViewModel: NSObject {
    
    public static let shared = TwilioViewModel()
    
    var objTwilioModel = TwilioModel()
    
    private override init() {}
    
    
    func getAccessToken(type:String,grpId:String,completion:@escaping completionHandler){
        var endpoint : String = ""
        
        if type == "video"{
            endpoint = APIConstant.kTwillioVieoToken
        }else{
            endpoint = APIConstant.kTwillioAudioToken
        }
        
        let url = APIConstant.kBaseUrl + endpoint
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"groupId":grpId]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                self?.objTwilioModel.setData(dict: response)
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    //MARK: Send Video Call API
    func sendCall(grpId:String,otherUserId:String,completion:@escaping completionHandler){
        
        let url = APIConstant.kBaseUrl + APIConstant.kTwillioCall
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"groupId":grpId,"otherId":otherUserId]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func acceptCall(grpId:String,otherUserId:String,completion:@escaping completionHandler){
        let url = APIConstant.kBaseUrl + APIConstant.kTwillioCallAccept
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"groupId":grpId,"otherId":otherUserId]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func rejectCall(grpId:String,otherUserId:String,completion:@escaping completionHandler){
        let url = APIConstant.kBaseUrl + APIConstant.kTwillioCallReject
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"groupId":grpId,"otherId":otherUserId]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    
    //MARK: Get Video Call Token
    func emptyVideoCallToken(){
        objTwilioModel.videoGrant = ""
        objTwilioModel.token = ""
    }
    
    func getTwilioCallToken()->(token:String,videoGrant:String){
        return (token:objTwilioModel.token,videoGrant:objTwilioModel.videoGrant)
    }

}
