//
//  CommentVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 24/10/21.
//

import UIKit

class CommentVC: UIViewController {

    @IBOutlet weak var vwMenu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: TableView Delegate and Datasource

extension CommentVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    
}

