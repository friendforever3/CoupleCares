//
//  HomeVM.swift
//  CoupleCare
//
//  Created by Surinder kumar on 17/12/21.
//

import UIKit
import MapKit

class HomeVM: NSObject {
    
    public static let shared = HomeVM()
    
    var nearByArray = [HomeModel]()
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var objUserDetailModel = UserDetailModel()
    
    private override init() {
    }
    
    func getNearBy(userId:String,page:String,pageSize:String,completion:@escaping completionHandler){
        
        let param = ["userId":userId,"page":0,"pageSize":100] as [String : Any]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kNearBy, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { (response, statusCode,errorMsg) in
            print("response nearby:-",response)
            
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [String:Any]{
                    self.nearByArray.removeAll()
                    if let result = data["result"] as? [[String:Any]]{
                        for elemnt in result.reversed(){
                            let obj = HomeModel()
                            obj.setData(dict: elemnt)
                            self.nearByArray.append(obj)
                            //self.nearByArray.reversed()
                        }
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func userDetail(userId:String,completion:@escaping completionHandler){
        
        let param = ["userId":userId]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kDetail, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { (response, statusCode,errorMsg) in
            
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [String:Any]{
                    self.objUserDetailModel.setData(dict: data)
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
        
    }
    
    
    //MARK: Get Home Data
    
    func nearByCount()->Int{
        return nearByArray.count
    }
    
    func getImageUrl(indexPath:Int)->String{
        return nearByArray[indexPath].profileImage
    }
    
    func getUserNameAge(indexPath:Int)->(name:String,age:String,id:String){
        return (name:nearByArray[indexPath].name,age:"\(nearByArray[indexPath].age)",id:nearByArray[indexPath].id)
    }
    
    func getUserInterestCount(index:Int)->Int{
        if nearByArray.count != 0{
           return nearByArray[index].interestArray.count
        }
        return 0
    }
    
    func getUserInterestDetail(index:Int,indexPath:IndexPath)->String{
        return nearByArray[index].interestArray[indexPath.row].name
    }
    
    func getUserDistance(index:Int)->String{
        
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return "0 Kmui"
            }
            
            let userLat = Double(nearByArray[index].coordinates.lat) ?? 0.0
            print("userLat:-",currentLocation.coordinate.latitude)
            
            let userLong  = Double(nearByArray[index].coordinates.long) ?? 0.0
            print("userlong:-",currentLocation.coordinate.longitude)
            print("distance:-",calculateDistance(mobileLocationX: currentLocation.coordinate.latitude, mobileLocationY: currentLocation.coordinate.longitude, DestinationX: userLat, DestinationY: userLong))
            return "\(calculateDistance(mobileLocationX: currentLocation.coordinate.latitude, mobileLocationY: currentLocation.coordinate.longitude, DestinationX: userLat, DestinationY: userLong)) Miles"
        }
        return "0 kmfd"
    }
    
    
    func calculateDistance(mobileLocationX:Double,mobileLocationY:Double,DestinationX:Double,DestinationY:Double) -> Double {
        
        let coordinate₀ = CLLocation(latitude: mobileLocationX, longitude: mobileLocationY)
        let coordinate₁ = CLLocation(latitude: DestinationX, longitude:  DestinationY)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        
        return distanceInMeters
    }
    
    func getUserCurrentLoc()->(lat:Double,long:Double){
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return (lat:0.0,long:0.0)
            }
           return (lat:currentLocation.coordinate.latitude,long:currentLocation.coordinate.longitude)
        }
        return (lat:0.0,long:0.0)
    }
    
    
    //MARK: User Detail Data
    func getUserDetailData()->(profileImg:String,bio:String,job:String,distance:String,age:String,fullName:String){
        
        let otherLat = Double(objUserDetailModel.coordinates.lat) ?? 0.0
        let otherLong = Double(objUserDetailModel.coordinates.long) ?? 0.0
        
        let dist = calculateDistance(mobileLocationX: getUserCurrentLoc().lat, mobileLocationY: getUserCurrentLoc().long, DestinationX: otherLat, DestinationY: otherLong)
        
        return (profileImg:objUserDetailModel.profileImg,bio:objUserDetailModel.bio,job:objUserDetailModel.jobTitle,distance:"\(dist)",age:"\(objUserDetailModel.age)",fullName:objUserDetailModel.fullName)
    }
    
    func getUserDetailData()->(gender:String,interestedIn:String,dob:String,lat:String,long:String){
        var gender : String = ""
        var interestedIn : String = ""
        if objUserDetailModel.gender == 1{
            gender = "Male"
        }else if objUserDetailModel.gender == 2{
            gender = "Female"
        }else{
            gender = "Other"
        }
        
        if objUserDetailModel.interestedIn == 1{
            interestedIn = "Men"
        }else if objUserDetailModel.interestedIn == 2{
            interestedIn = "Women"
        }else{
            interestedIn = "All"
        }
        
        
        let dob = UtilityManager.shared.getDate(dateString: objUserDetailModel.dob, inputDateformat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputDateFormate: "dd/MM/yyyy")
        
        
        
        
        return (gender:gender,interestedIn:interestedIn,dob:dob,lat:objUserDetailModel.coordinates.lat,long:objUserDetailModel.coordinates.long)
    }
    
    func getGenderString()->String{
        return "\(objUserDetailModel.gender)"
    }
    
    func getInterestedInString()->String{
        return "\(objUserDetailModel.interestedIn)"
    }
    
    func getUserAge()->String{
        return "\(objUserDetailModel.age)"
    }
    
    func getAllUserDetailSelectedInterests()->[InterestModel]{
        return objUserDetailModel.interestArray
    }
    
    func getUserDetailInterestCount()->Int{
        return objUserDetailModel.interestArray.count
    }
    
    func getUserDetailInterestCell(indexPath:IndexPath)->String{
        return objUserDetailModel.interestArray[indexPath.row].name
    }
    
    func getUserDetailPhotosCount()->Int{
        return objUserDetailModel.photosArray.count
    }
    
    func getUserDetailPhotoCell(indexPath:IndexPath)->(imgId:String,imgUrl:String){
        return (imgId:objUserDetailModel.photosArray[indexPath.row].imageId,imgUrl:objUserDetailModel.photosArray[indexPath.row].url)
    }
    

}
