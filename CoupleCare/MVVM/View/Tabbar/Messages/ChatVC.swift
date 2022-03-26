//
//  ChatVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit
import IQKeyboardManager

class ChatVC: UIViewController {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var vwMenuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTblVw: UITableView!
    @IBOutlet weak var tfMsg: TextFieldCustom!
    @IBOutlet weak var vwChatBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgNavUser: ImageCustom!
    @IBOutlet weak var lblNavUser: UILabel!
    
    var otherUserId : String = ""
    var grpId : String = ""
    var otherImgurl : String = ""
    var otherUserName : String = ""
    
    var isVideo : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatTblVw.delegate = self
        chatTblVw.dataSource = self
        
        chatTblVw.estimatedRowHeight = 50
        chatTblVw.rowHeight = UITableView.automaticDimension
      //  vwMenuHeightConstraint.constant = 0
        initliaseSocketConnection()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        getChatHistory(grpId: grpId, page: 1, size: 10000000)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        lblNavUser.text = otherUserName
        UtilityManager.shared.setImage(image: imgNavUser, urlString: otherImgurl)
        //chatTblVw.scrollToBottom(isAnimated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            
            if MessageVM.shared.getAllChatListCount() != 0{
               chatTblVw.scrollToBottom(isAnimated: false)
            }
            
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 2436:
                    vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    self.view.layoutIfNeeded()
                default:
                   
                    
                    if UIDevice.current.hasNotch
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    }
                    else
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height)
                    }
                    
                    
                    self.view.layoutIfNeeded()
                }
            }else if UIDevice().userInterfaceIdiom == .pad {
                switch UIScreen.main.nativeBounds.height {
                case 2436:
                    vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    self.view.layoutIfNeeded()
                default:
                    if UIDevice.current.hasNotch
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height) - 0
                    }
                    else
                    {
                        vwChatBottomConstraint.constant = (keyboardSize.height)
                    }
                    
                    self.view.layoutIfNeeded()
                }
            }
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            vwChatBottomConstraint.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    
    func initliaseSocketConnection(){
        SocketConnectionManager.shared.connectSocket { (success) in
            print("recieve",success)
        }
        
        SocketConnectionManager.shared.listen(listnerKey: grpId) {
            self.chatTblVw.reloadData()

            if MessageVM.shared.getAllChatListCount() != 0{
              self.chatTblVw.scrollToBottom(isAnimated: true)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isVideo{
            SocketConnectionManager.shared.off(listnerKey: grpId)
            IQKeyboardManager.shared().isEnabled = true
            IQKeyboardManager.shared().isEnableAutoToolbar = true
            SocketConnectionManager.shared.disconnectSocket()
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        vwBg.isHidden = false

        //vwMenuHeightConstraint.constant = 247
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }

    }
    @IBAction func btnCloseMenuAction(_ sender: Any) {
        vwBg.isHidden = true
       // vwMenuHeightConstraint.constant = 0
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    @IBAction func btnVideoCallAction(_ sender: Any) {
        isVideo = true
        let vc = VideoCallVC.getVC(.Call)
        vc.grpId = self.grpId
        self.push(vc)
    }
    
    @IBAction func btnAudioCallAction(_ sender: Any) {
        isVideo = true
        let vc = VoiceCallVC.getVC(.Call)
        vc.grpId = self.grpId
        self.push(vc)
    }
    
    @IBAction func btnSendMsgAction(_ sender: Any) {
        if !(tfMsg.text?.isEmptyOrWhitespace() ?? false){
            let emitData = [
                "groupId": grpId,
                "receiverId": otherUserId,
                "senderId": UtilityManager.shared.userDecodedDetail().id,
                "username": HomeVM.shared.getUserDetailData().fullName,
                "profileImage": HomeVM.shared.getUserDetailData().profileImg,
                "timezone":UtilityManager.shared.getCurrentTimeZone(),
                "msg": tfMsg.text ?? ""
            ]
            //let dict = ["listener":grpId,"data":emitData] as [String : Any]
            SocketConnectionManager.shared.emit(emitterKey: "sendMessage", params: emitData)
            tfMsg.text = ""
        }
    }
    

}

//MARK:- TableView
extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageVM.shared.getAllChatListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UtilityManager.shared.userDecodedDetail().id == MessageVM.shared.getChatDetailCell(indexPath: indexPath).senderId{
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! ChatTblCell
            cell.lblSenderTime.text = MessageVM.shared.getChatDetailCell(indexPath: indexPath).time
            cell.lblSenderMsg.text = MessageVM.shared.getChatDetailCell(indexPath: indexPath).msg
        return cell
        }
        let recieverCell = tableView.dequeueReusableCell(withIdentifier: "recieverCell", for: indexPath) as! ChatTblCell
        recieverCell.lblRecieverMsg.text = MessageVM.shared.getChatDetailCell(indexPath: indexPath).msg
        recieverCell.lblRecieverTime.text = MessageVM.shared.getChatDetailCell(indexPath: indexPath).time
        return recieverCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: API
extension ChatVC{
    
    func getChatHistory(grpId:String,page:Int,size:Int){
        
        MessageVM.shared.getChatHistory(grpId: grpId, page: page, size: size) { [weak self] (success,msg) in
            
            if success{
                self?.chatTblVw.reloadData()
                if MessageVM.shared.getAllChatListCount() != 0{
                  self?.chatTblVw.scrollToBottom(isAnimated: false)
                }
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
