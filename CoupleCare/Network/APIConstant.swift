//
//  APIConstant.swift
//  CoupleCare
//
//  Created by Surinder kumar on 14/12/21.
//

import Foundation


struct APIConstant{
 
    static let kSandvboxBaseUrl = "http://3.13.194.181:5004/api/v1/"
    static let kUser = "user/"
    static let kAdmin = "admin/"
    
    static let kSendOTP = kUser + "otp"
    static let kVerifyotp = kUser + "verifyotp"
    static let kResendotp = kUser + "resendotp"
    static let kInterestList = kAdmin + "interest/list"
    
    static let kRegister = kUser + "register"
    
    
}

struct AppConstant{
    
    static let KOops = "Oops"
    static let kMsgMobile = "Please enter the mobile number"
    static let kMsgFullName = "Please enter the full name"
    static let kMsgDOB = "Please enter your birthday"
    static let kMsgGender = "Please select the gender"
    static let kMsgInterestedIn = "Please select the interested in"
    static let kMsgInterest = "Please select any interest"
    static let kMsgImage = "Please select the image"
    
}
