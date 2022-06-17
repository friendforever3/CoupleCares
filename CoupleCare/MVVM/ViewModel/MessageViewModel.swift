//
//  MessageVM.swift
//  CoupleCare
//
//  Created by Surinder kumar on 06/03/22.
//

import UIKit

class MessageViewModel: NSObject {
    
    public static let shared = MessageViewModel()
    
    var msgUserList = [MessageModel]()
    var chatListArray = [ChatModel]()
    
    private override init() {}
    
    func getMessageList(completion:@escaping completionHandler){
        
        let url = APIConstant.kBaseUrl + APIConstant.kChatGroup
        let param = ["userId":UtilityManager.shared.userDecodedDetail().id]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    self?.msgUserList.removeAll()
                    for elmnt in data{
                        let obj = MessageModel()
                        obj.setData(dict: elmnt)
                        self?.msgUserList.append(obj)
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func getChatHistory(grpId:String,page:Int,size:Int,completion:@escaping completionHandler){
        
        let url = APIConstant.kBaseUrl + APIConstant.kChatHistory
        let param = ["groupId":grpId,"page":"\(page)","size":size] as [String : Any]
        
        serverRequest(url: url, param: param, method: .post, header: UtilityManager.shared.getHeaderToken(),loaderShow: false) { [weak self] (response, statusCode,errorMsg) in
            if response["statusCode"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    self?.chatListArray.removeAll()
                    for elmnt in data{
                        let obj = ChatModel()
                        obj.setData(dict: elmnt)
                        self?.chatListArray.append(obj)
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
        
    }
    
    
    //MARK: Message List
    func getMessageCount()->Int{
        return msgUserList.count
    }
    
    func getMsgUserDetail(indexPath:IndexPath)->(name:String,msg:String,imgUrl:String,time:String,groupId:String,otherUserId:String,otherProfileImg:String){
        return (name:msgUserList[indexPath.row].otherfullName,msg:msgUserList[indexPath.row].msg,imgUrl:msgUserList[indexPath.row].profileImage,time:msgUserList[indexPath.row].time,groupId:msgUserList[indexPath.row].groupId,otherUserId:msgUserList[indexPath.row].other_id,otherProfileImg:msgUserList[indexPath.row].profileImage)
    }
    
    
    //MARK: Get Chat List
    func removeAllChat(){
        self.chatListArray.removeAll()
    }
    
    func getAllChatListCount()->Int{
        return self.chatListArray.count
    }
    
    func setAllChatDictionary(dict:[String:Any]){
        let obj = ChatModel()
        obj.setData(dict: dict)
        self.chatListArray.append(obj)
    }
    
    func getChatDetailCell(indexPath:IndexPath)->(msg:String,recieverId:String,senderId:String,time:String){
        return (msg:self.chatListArray[indexPath.row].msg,recieverId:self.chatListArray[indexPath.row].receiverId,senderId:self.chatListArray[indexPath.row].senderId,time:self.chatListArray[indexPath.row].time)
    }
    

}
