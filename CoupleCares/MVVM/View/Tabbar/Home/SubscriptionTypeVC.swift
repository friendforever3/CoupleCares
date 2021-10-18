//
//  SubscriptionTypeVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

protocol ControllerDeleagte{
    func didCloseDelegate()
}

class SubscriptionTypeVC: UIViewController {

    var delegate : ControllerDeleagte?
    
    var objectArray = ["Get 30 boosts monthly","See who likes you","Enjoy the power of superlike","Increase your profiles discoverability"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.delegate?.didCloseDelegate()
        self.dismiss(animated: true) {
            
        }
        
    }
    @IBAction func btnPayAction(_ sender: Any) {
        let vc = PaymentVC.getVC(.Home)
       // let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

//MARK: Tableview Delegate and Datsource
extension SubscriptionTypeVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
            cell.lblFeature.text = objectArray[indexPath.row]
            
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 32
    }
    
}
