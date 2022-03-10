//
//  UserVM.swift
//  CoupleCare
//
//  Created by Surinder kumar on 14/12/21.
//

import UIKit

class UserVM: NSObject {
    
    static public let shared = UserVM()
    
    var interestListArray = [InterestModel]()
    
    private override init() {}

    
    func sendMobileOTP(mobileNo:String,countryCode:String,completion:@escaping completionHandler){
        let param = ["mobileNumber": mobileNo,"countryCode": countryCode]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kSendOTP, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [String:Any]{
                    UtilityManager.shared.userToken = data["token"] as? String ?? ""
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func verifyOTP(mobileNo:String,countryCode:String,OTP:String,completion:@escaping completionHandler){
        
        let param = ["mobileNumber": mobileNo,"countryCode": countryCode,"OTP":OTP]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kVerifyotp, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
            
            if response["statusCode"] as? Int == 200{
                
                if let data = response["data"] as? [String:Any]{
                    let obj = UserModel()
                    obj.setData(dict: data)
                    UtilityManager.shared.userDataEncode(obj)
                }
                
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
        
    }
    
    func resendOTP(mobileNo:String,countryCode:String,completion:@escaping completionHandler){
        let param = ["mobileNumber": mobileNo,"countryCode": countryCode]
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kResendotp, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func getListInterest(completion:@escaping completionHandler){
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kInterestList, param: nil, method: .get, header: nil) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                self.interestListArray.removeAll()
                if let data = response["data"] as? [[String:Any]]{
                    for element in data{
                        let obj = InterestModel()
                        obj.setData(dict: element)
                        self.interestListArray.append(obj)
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func register(completion:@escaping completionHandler){
        let param = ["mobileNumber":RegisterModel.shared.mobileNo,"countryCode":RegisterModel.shared.dailCode,"fullName":RegisterModel.shared.fullName,"interestedIn":RegisterModel.shared.interestedIn,"gender":RegisterModel.shared.gender,"age":RegisterModel.shared.age,"dob":RegisterModel.shared.DOB,"interests":RegisterModel.shared.interests,"lat":RegisterModel.shared.lat,"lng":RegisterModel.shared.long] as [String : Any]
        
        uploadDataToServerHandler(url: APIConstant.kBaseUrl + APIConstant.kRegister, param: param, imgData: RegisterModel.shared.images, fileName: "images") { (response) in
            
            print("respinse Register:-",response)
            if response?["statusCode"] as? Int == 200{
                
                if let data = response?["data"] as? [String:Any]{
                    let obj = UserModel()
                    obj.setData(dict: data)
                    UtilityManager.shared.userDataEncode(obj)
                }
                
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
    }
    
    func updateProfile(keyName:String,value:String,age:String?=nil,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,keyName:value]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kUpdateprofile, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func updateProfile2(keyName:String,value:String,keyName2:String,value2:String,keyName3:String?=nil,value3:String?=nil,completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,keyName:value,keyName2:value2]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kUpdateprofile, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func updateInterestProfile(keyName:String,value:[String],completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id,keyName:value] as [String : Any]
        
        serverRequest(url: APIConstant.kBaseUrl + APIConstant.kUpdateprofile, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func updateMutipleImages(selectedImages:[Data],completion:@escaping completionHandler){
        
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id]
        
        uploadDataToServerHandler(url: APIConstant.kBaseUrl + APIConstant.kUpdateimages, param: param, imgData: selectedImages, fileName: "images") { (response) in
            
            if response?["statusCode"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
            
        }
        
        
    }
    
    
    
    //MARK: Get Interest List
    func removeAllInterest(){
        interestListArray.removeAll()
    }
    
    func getAllInterest()->[InterestModel]{
        return interestListArray
    }
    
    func getInterestCount()->Int{
        return interestListArray.count
    }
    
    func getInterestCellDetail(indexPath:IndexPath)->(name:String,id:String){
        return (name:interestListArray[indexPath.row].name,id:interestListArray[indexPath.row]._id)
    }
    
}
