//
//  ProfileVM.swift
//  CoupleCare
//
//  Created by Surinder kumar on 19/12/21.
//

import UIKit
import SwiftUI

class ProfileVM: NSObject {
    
    public static let shared = ProfileVM()
    
    private override init() {}
    
    
    func removeImg(imageId:String,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,"imageId":imageId]
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kRemoveImage, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            print(response)
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
        
    }
    
    
    func updateProfileImg(imgData:Data,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id]
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUpdateprofileimage, param: param, imgData: [imgData], fileName: "profileImage") { (response) in
            
            print("respinse updateProfileImg:-",response)
            if response?["statusCode"] as? Int == 200{
                
                //UtilityManager.shared.userDataEncode(obj)
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
    }

}
