//
//  MessageListVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit

class MessageListVC: UIViewController {

    @IBOutlet weak var msgTblVw: UITableView!
    @IBOutlet weak var matchClcVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getMessageList()
    }
    
   
}

//MARK:- CollectionView
extension MessageListVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 68)
    }
    
    
}

//MARK:- TableView
extension MessageListVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageVM.shared.getMessageCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath) as! MessageTblCell
        UtilityManager.shared.setImage(image: cell.imgUser, urlString: MessageVM.shared.getMsgUserDetail(indexPath: indexPath).imgUrl)
        
        cell.lblMsg.text = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).msg
        cell.lblUserName.text = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).name
        cell.lblMsgTime.text = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        let vc = ChatVC.getVC(.Message)
        vc.otherUserId = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).otherUserId
        vc.otherImgurl = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).imgUrl
        vc.grpId = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).groupId
        vc.otherUserName = MessageVM.shared.getMsgUserDetail(indexPath: indexPath).name
        self.push(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
}

//MARK: API
extension MessageListVC{
    
    func getMessageList(){
        MessageVM.shared.getMessageList { [weak self] (success,msg) in
            if success{
                self?.msgTblVw.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
