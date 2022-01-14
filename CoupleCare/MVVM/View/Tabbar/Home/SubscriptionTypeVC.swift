//
//  SubscriptionTypeVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit
import ScalingCarousel

class SubscriptionTypeVC: UIViewController {

    @IBOutlet weak var clcVw: ScalingCarouselView!
    @IBOutlet weak var vwMenu: UIView!
    @IBOutlet weak var vwMenu1: UIView!
    @IBOutlet weak var vwMenu2: UIView!
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwMenu.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        self.vwMenu1.roundCorners(corners: [.topRight, .bottomRight], radius: 16)
        self.vwMenu2.roundCorners(corners: [.topLeft, .bottomLeft], radius: 16)
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

//MARK: CollectionView Delegate and Datsource
extension SubscriptionTypeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 8
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScalingCarouselCell
            
            if let scalingCell = cell as? ScalingCarouselCell {
                scalingCell.mainView.backgroundColor = .blue
            }
            DispatchQueue.main.async {
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }

            return cell
        }
    
    
    
}

class ScalingCarouselCell : UICollectionViewCell{
    
    
    @IBOutlet weak var mainView: UIView!
    
}
