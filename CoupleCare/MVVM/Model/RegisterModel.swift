//
//  RegisterModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/12/21.
//

import Foundation
import UIKit


class RegisterModel : NSObject{
    
    public static var shared = RegisterModel()
    
    private override init() {}
    
    var mobileNo : String = ""
    var dailCode : String = ""
    var fullName : String = ""
    var DOB : String = ""
    var age : String = ""
    var gender : String = ""
    var interestedIn : String = ""
    var interests = [String]()
    var images = [Data]()
    var lat : String = ""
    var long : String = ""
    
}
