//
//  ProfileSettingVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 18/10/21.
//

import UIKit

class ProfileSettingVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    let objectArray = ["Location","Blocked Contacts","Invite Friends","Delete Account","Contact Us","Terms & Conditions", "Privacy Policy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblVw.estimatedSectionHeaderHeight = 480
        tblVw.sectionHeaderHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        
        logout()
        
    }
    
    func logout(){
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let vc = LoginVC.getVC(.Main)
        navigationController?.pushViewController(vc, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        app.window?.rootViewController = navigationController
        app.window?.makeKeyAndVisible()
    }
    
}

    //MARK: Tableview Delegate and Datasource
extension ProfileSettingVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        cell.lblProSetting.text = objectArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        switch objectArray[indexPath.row]{
            
        case "Location":
            break
        case "Blocked Contacts":
            let vc = BlockedContactVC.getVC(.Profile)
            self.push(vc)
            break
        case "Invite Friends":
            
            break
        case "Delete Account":
            let vc = DeleteAccVC.getVC(.Profile)
            self.push(vc)
            break
        case "Contact Us":
            let vc = ContactUsVC.getVC(.Profile)
            self.push(vc)
            break

        default:
            print("default")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = SettingView.instance
        return vw
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
