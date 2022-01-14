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
        editProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setUI(){
        print("profileimga",UtilityManager.shared.userDecodedDetail().profileImage)
        UtilityManager.shared.setImage(image: imgProfile, urlString: HomeVM.shared.getUserDetailData().profileImg)
        lblUserNameAge.text = HomeVM.shared.getUserDetailData().fullName + ", " + HomeVM.shared.getUserDetailData().age
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
                UtilityManager.shared.displayAlert(title: "", message: msg, control: ["OK"], topController: self ?? UIViewController())
                self?.editProfile()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func editProfile(){
        HomeVM.shared.userDetail(userId: UtilityManager.shared.userDecodedDetail().id) { [weak self] (success,msg) in
            if success{
                self?.setUI()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
