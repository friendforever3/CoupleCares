//
//  LikesVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class LikesVC: UIViewController {

    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var vwReport: UIView!
    
    var isLike : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLike{
            vwMenu.isHidden = false
            vwReport.isHidden = true
        }else{
            vwMenu.isHidden = true
            vwReport.isHidden = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        self.vwReport.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
   
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: TableView Delegate and Datasource

extension LikesVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    
}

