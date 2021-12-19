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
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kSendOTP, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
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
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kVerifyotp, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
            
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
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kResendotp, param: param, method: .post, header: nil) { (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func getListInterest(completion:@escaping completionHandler){
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kInterestList, param: nil, method: .get, header: nil) { (response, statusCode,errorMsg) in
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
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kRegister, param: param, imgData: RegisterModel.shared.images, fileName: "images") { (response) in
            
            print("respinse Register:-",response)
            if response?["statusCode"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
    }
    
    
    
    
    //MARK: Get Interest List
    func getInterestCount()->Int{
        return interestListArray.count
    }
    
    func getInterestCellDetail(indexPath:IndexPath)->(name:String,id:String){
        return (name:interestListArray[indexPath.row].name,id:interestListArray[indexPath.row]._id)
    }
    
}
