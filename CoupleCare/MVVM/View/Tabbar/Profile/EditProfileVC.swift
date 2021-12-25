//
//  EditProfileVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 09/10/21.
//

import UIKit
import Photos
import OpalImagePicker
import SwiftUI

class EditProfileVC: UIViewController {

    @IBOutlet weak var profileTblVw: UITableView!
    
    var objectArray = [["type":"clc","value":""],["type":"Bio","value":"Lorem ipsum dolor sit amet, consectetur"],["type":"clc","value":""],["type":"Gender","value":"Male"],["type":"Job Title","value":"Musician"],["type":"Your Location","value":"LA"],["type":"Interested In","value":"Women"],["type":"Birthday","value":"12/03/1995"]]
    
    var selectedPhots = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        editProfile()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    func setUI(){
        
        objectArray[1]["value"] = HomeVM.shared.getUserDetailData().bio
        objectArray[3]["value"] = HomeVM.shared.getUserDetailData().gender
        objectArray[4]["value"] = HomeVM.shared.getUserDetailData().job
        objectArray[6]["value"] = HomeVM.shared.getUserDetailData().interestedIn
        objectArray[7]["value"] = HomeVM.shared.getUserDetailData().dob
        
        profileTblVw.reloadData()
    }
    
}

//MARK: Tableview Delegate and Datsource
extension EditProfileVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath) as! ProfileCell
            cell.photosClcVw.reloadData()
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "interestCell", for: indexPath) as! ProfileCell
            cell.interestClcVw.reloadData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! ProfileCell
            cell.lblType.text = objectArray[indexPath.row]["type"]
            cell.lblValue.text = objectArray[indexPath.row]["value"]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        if objectArray[indexPath.row]["type"] == "Gender"{
            let vc = UpdateGenderVC.getVC(.UpdateProfile)
            vc.genderSelected = HomeVM.shared.getGenderString()
            self.push(vc)
        }else if objectArray[indexPath.row]["type"] == "Interested In"{
            let vc = UpdateInterestedInVC.getVC(.UpdateProfile)
            vc.interestSelected = HomeVM.shared.getInterestedInString()
            self.push(vc)
        }else if objectArray[indexPath.row]["type"] == "Birthday"{
            let vc = UpdateBirthdayVC.getVC(.UpdateProfile)
            vc.age = HomeVM.shared.getUserAge()
            vc.dob = objectArray[indexPath.row]["value"] ?? ""
            self.push(vc)
        }else if objectArray[indexPath.row]["type"] == "clc"{
            let vc = UpdateInterestVC.getVC(.UpdateProfile)
            vc.selectedIds = HomeVM.shared.getAllUserDetailSelectedInterests()
            self.push(vc)
        }else if objectArray[indexPath.row]["type"] == "Bio"{
            let vc = UpdateBioVC.getVC(.UpdateProfile)
            vc.bioTxt = HomeVM.shared.getUserDetailData().bio
            self.push(vc)
        }else if objectArray[indexPath.row]["type"] == "Job Title"{
            let vc = UpdateJobTitleVC.getVC(.UpdateProfile)
            self.push(vc)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else if indexPath.row == 2{
            if HomeVM.shared.getUserDetailInterestCount() != 0{
            let count = HomeVM.shared.getUserDetailInterestCount() % 3
            let divide = HomeVM.shared.getUserDetailInterestCount() / 3
            var height : CGFloat = 0.0
            if count == 0{
                let counttotl : CGFloat = CGFloat(divide)
                height = 85 + (counttotl * 53)
            }else{
                let counttotl : CGFloat = CGFloat(divide + 1)
                height = 85 + (counttotl * 53)
                
            }
            
            return height
            }
            return 0
        }else{
            return UITableView.automaticDimension
        }
    }
    
}

//MARK: CollectionView datasource and delegate
extension EditProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return 6
        }
        return HomeVM.shared.getUserDetailInterestCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        
        if collectionView.tag == 1{
            if indexPath.row < 6{
                if HomeVM.shared.getUserDetailPhotosCount() > indexPath.row{
                   // cell.imgProfileImages.image = selectedPhots[indexPath.row]
                    
                    UtilityManager.shared.setImage(image: cell.imgProfileImages, urlString: HomeVM.shared.getUserDetailPhotoCell(indexPath: indexPath).imgUrl)
                    cell.imgProfileAddIcon.isHidden = true
                    cell.btnProfileDelete.isHidden = false
                }else{
                    cell.imgProfileImages.image = UIImage(named: "imgBg")
                   cell.btnProfileDelete.isHidden = true
                    cell.imgProfileAddIcon.isHidden = false
                }
            }
            
            cell.btnProfileDelt = { [weak self] btn in
                self?.delteImg(imgId: HomeVM.shared.getUserDetailPhotoCell(indexPath: indexPath).imgId)
            }
            
        }else{
            
            cell.lblInterest.text = HomeVM.shared.getUserDetailInterestCell(indexPath: indexPath)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1{
            let imagePicker = OpalImagePickerController()
            imagePicker.imagePickerDelegate = self
            //imagePicker.maximumSelectionsAllowed = 6
            let count = (6 - (HomeVM.shared.getUserDetailPhotosCount()))
            imagePicker.maximumSelectionsAllowed = count
            imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
            imagePicker.view.backgroundColor = .white
            if selectedPhots.count < 6{
               present(imagePicker, animated: true, completion: nil)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
         return CGSize(width: ((collectionView.frame.size.width) / 3) - 10, height: 132)
        }
        return CGSize(width: ((collectionView.frame.size.width) / 3) - 10, height: 48)
    }
    
}

extension EditProfileVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        //Save Images, update UI
       
        print("sdd",assets.count)
        print("UtilityManager.shared.getAssetThumbnail(assets: assets):-",getAssetThumbnail(assets: assets).count)
        
        for img in getAssetThumbnail(assets: assets){
            selectedPhots.append(img.pngData() ?? Data())
        }
       
        updateImages()
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
         var arrayOfImages = [UIImage]()
         for asset in assets {
             let manager = PHImageManager.default()
             let option = PHImageRequestOptions()
             var image = UIImage()
             option.isSynchronous = true
             manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                 image = result!
                 arrayOfImages.append(image)
             })
         }

         return arrayOfImages
     }
    
    
}


//MARK: API
extension EditProfileVC{
    
    func editProfile(){
        HomeVM.shared.userDetail(userId: UtilityManager.shared.userDecodedDetail().id) { [weak self] (success,msg) in
            if success{
                self?.setUI()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func delteImg(imgId:String){
        ProfileVM.shared.removeImg(imageId: imgId) { [weak self] (success,msg) in
            if success{
                self?.editProfile()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func updateImages(){
        
        UserVM.shared.updateMutipleImages(selectedImages: selectedPhots) { [weak self] (success,msg) in
            if success{
                self?.editProfile()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
    
}
