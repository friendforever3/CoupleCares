//
//  ChatVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var vwMenuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTblVw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatTblVw.delegate = self
        chatTblVw.dataSource = self
        
        chatTblVw.estimatedRowHeight = 86
        chatTblVw.rowHeight = UITableView.automaticDimension
        vwMenuHeightConstraint.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        vwMenuHeightConstraint.constant = 247
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }

    }
    @IBAction func btnCloseMenuAction(_ sender: Any) {
        vwMenuHeightConstraint.constant = 0
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
}

//MARK:- TableView
extension ChatVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath)
        return cell
        }
        let recieverCell = tableView.dequeueReusableCell(withIdentifier: "recieverCell", for: indexPath)
        return recieverCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

