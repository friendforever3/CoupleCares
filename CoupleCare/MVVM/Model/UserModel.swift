//
//  UserModel.swift
//  CoupleCare
//
//  Created by Surinder kumar on 17/12/21.
//

import Foundation

class UserModel : Codable{
    
    var id : String = ""
    var isOTPVerified : Bool = false
    var token : String = ""
    var profileImage : String = ""
    var fullName : String = ""
    var isRegistered : Bool = false
    
    func setData(dict:[String:Any]){
        self.id = dict["_id"] as? String ?? ""
        self.isOTPVerified = dict["isOTPVerified"] as? Bool ?? false
        self.token = dict["token"] as? String ?? ""
        self.profileImage = dict["profileImage"] as? String ?? ""
        self.fullName = dict["fullName"] as? String ?? ""
        self.isRegistered = dict["isRegistered"] as? Bool ?? false
        
    }
    
}

class UserDetailModel : Codable{
    
    var profileImg : String = ""
    var bio : String = ""
    var interestArray = [InterestModel]()
    var jobTitle : String = ""
    var age : Int = 0
    var fullName : String = ""
    var interestedIn : Int = 0
    var gender : Int = 0
    var dob : String = ""
    var photosArray = [PhotoModel]()
    var coordinates = CoordinateModel()
    
    func setData(dict:[String:Any]){
        
        self.profileImg = dict["profileImage"] as? String ?? ""
        self.fullName = dict["fullName"] as? String ?? ""
        self.bio = dict["bio"] as? String ?? ""
        self.jobTitle = dict["job"] as? String ?? ""
        age = dict["age"] as? Int ?? 0
        interestedIn = dict["interestedIn"] as? Int ?? 0
        gender = dict["gender"] as? Int ?? 0
        self.dob = dict["dob"] as? String ?? ""
        self.interestArray.removeAll()
        if let interests = dict["interests"] as? [[String:Any]]{
            for elemnt in interests{
                let obj = InterestModel()
                obj.setData(dict: elemnt)
                self.interestArray.append(obj)
            }
        }
        
        self.photosArray.removeAll()
        if let images = dict["images"] as? [[String:Any]]{
            for elemnt in images{
                let obj = PhotoModel()
                obj.setData(dict: elemnt)
                self.photosArray.append(obj)
            }
        }
        
        if let coordinate = dict["coordinates"] as? [String:Any]{
            coordinates.setData(dict: coordinate)
        }
        
    }
    
    
}

class PhotoModel : Codable {
    
    var imageId : String = ""
    var url : String = ""
    var id : String = ""
    
    func setData(dict:[String:Any]){
        self.id = dict["_id"] as? String ?? ""
        self.imageId = dict["imageId"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
    }
    
}
