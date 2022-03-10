//
//  APIHandler.swift
//  Gospel
//
//  Created by Surinder kumar on 21/09/21.
//

import Foundation
import Alamofire

typealias responseCompletion = ([String:Any],Int,String)
typealias responseCompletionArray = ([[String:Any]],Int,String)

func serverRequest(url:String,param:[String:Any]?,method:HTTPMethod,header:HTTPHeaders? ,loaderShow:Bool=true,completion:@escaping(responseCompletion)->()){
    
    if loaderShow{
        Indicator.shared.start("")
    }
    print("url:-",url)
    print("param:-",param)
    print(header)
    AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
        Indicator.shared.stop()
        
        if let data = response.data, let str = String(data: data, encoding: .utf8){
            print("server error:-",str)
        }
        
        print(response)
        switch response.result {
        case .success(_):
            print("data:-",response.response?.statusCode)
            if let dict = response.value as? [String:Any]{
                completion((dict,response.response?.statusCode ?? -1,""))
            }
            
            
            break
        case .failure(let error):
            completion(([:],response.response?.statusCode ?? -1,error.localizedDescription ))
            break
        }
        
    }
    
    
    
}

func serverRequesArrayt(url:String,param:[String:Any]?,method:HTTPMethod,header:HTTPHeaders? ,completion:@escaping(responseCompletionArray)->()){
    
    Indicator.shared.start("")
    print("url:-",url)
    AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: param, headers: header).responseJSON { response in
        Indicator.shared.stop()
        
        
        print(response)
        
        switch response.result {
        case .success(_):
            print("dataUrl:-",response.response?.statusCode)
            if let dict = response.value as? [[String:Any]]{
                completion((dict,response.response?.statusCode ?? -1,""))
            }else{
                completion(([[:]],response.response?.statusCode ?? -1,"" ))
            }
            
            
            break
        case .failure(let error):
            completion(([[:]],response.response?.statusCode ?? -1,error.localizedDescription ))
            break
        }
        
    }
    
    
    
}

func uploadDataToServerHandler(url:String,param:[String:Any]?,imgData:[Data]?,fileName:String,completion:@escaping ([String:Any]?)->()){
    
    print(url)
    print(param)
    Indicator.shared.start("")
    AF.upload(multipartFormData: { (multipartData) in
        
        if let parm = param{
            for (key,value) in parm{
                    multipartData.append("\(value)".data(using: .utf8)!, withName: key)

            }
        }
        
        if let imageData = imgData{
            print("imgcount:-",imageData.count)
            for imgDat in imageData{
            multipartData.append(imgDat, withName: fileName, fileName: "\(UUID().uuidString).png", mimeType: "\(UUID().uuidString)/png")
            }
        }
        
        
    }, to: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, usingThreshold: UInt64.init(), method: .post, headers: nil).response { (response) in
        print("ghgg",response)
        Indicator.shared.stop()
        if let data = response.data, let str = String(data: data, encoding: .utf8){
            print("server error:-",str)
        }
        
        switch (response.result){
        case .success(_):
            if let responseData = response.value as? Data{
            do {
                let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any]
                    completion(data)
                }catch{
                    completion([:])
                }
            }
            
            break
        case .failure(let error):
            print("errr",error.localizedDescription)
            completion([:])
            break
        }
        
    }
    
    
}
