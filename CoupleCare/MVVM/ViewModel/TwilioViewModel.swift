//
//  TwilioViewModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/03/22.
//

import UIKit

class TwilioViewModel: NSObject {
    
    public static let shared = TwilioViewModel()
    
    var objCallModel = CallModel()
    
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
                self?.objCallModel.setData(dict: response)
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    
    //MARK: Get Video Call Token
    func emptyVideoCallToken(){
        objCallModel.videoGrant = ""
        objCallModel.token = ""
    }
    
    func getTwilioCallToken()->(token:String,videoGrant:String){
        return (token:objCallModel.token,videoGrant:objCallModel.videoGrant)
    }

}
