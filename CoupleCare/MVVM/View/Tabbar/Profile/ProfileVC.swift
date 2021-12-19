//
//  ProfileVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 09/10/21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserNameAge: UILabel!
    
    var imgData : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UtilityManager.shared.setImage(image: imgProfile, urlString: UtilityManager.shared.userDecodedDetail().profileImage)
        lblUserNameAge.text = UtilityManager.shared.userDecodedDetail().fullName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        
        
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        let vc = EditProfileVC.getVC(.Profile)
        self.push(vc)
    }
    
    @IBAction func btnSettingAction(_ sender: Any) {
        let vc = ProfileSettingVC.getVC(.Profile)
        self.push(vc)
    }
    
    @IBAction func btnProfileImgAction(_ sender: Any) {
        
        ImagePickerManager().pickImage(self){ image in
               //here is the image
            self.imgData = image.jpegData(compressionQuality: 0.75)
            self.imgProfile.image = image
            
            self.updateProfileImg()
        }
        
    }
    
    
}

//MARK: API
extension ProfileVC{
    
    func updateProfileImg(){
        
        ProfileVM.shared.updateProfileImg(imgData: imgData ?? Data()) { [weak self] (success,msg) in
            
            if success{
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
