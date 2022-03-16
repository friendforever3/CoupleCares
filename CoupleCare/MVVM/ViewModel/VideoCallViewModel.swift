//
//  VideoCallViewModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/03/22.
//

import UIKit

class VideoCallViewModel: NSObject {
    
    public static let shared = VideoCallViewModel()
    
    var objCallModel = CallModel()
    
    private override init() {}
    
    
    func getAccessToken(grpId:String,completion:@escaping completionHandler){
        
        let url = APIConstant.kBaseUrl + APIConstant.kTwillioVieoToken
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
    
    func getVideoCallToken()->(token:String,videoGrant:String){
        return (token:objCallModel.token,videoGrant:objCallModel.videoGrant)
    }

}
