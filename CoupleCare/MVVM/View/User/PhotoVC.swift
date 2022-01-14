//
//  PhotoVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 25/09/21.
//

import UIKit
import Photos
import OpalImagePicker

class PhotoVC: UIViewController {

    @IBOutlet weak var vwPhotoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoClcVw: UICollectionView!
    
    var selectedPhots = [UIImage]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwPhotoHeightConstraint.constant = 275
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnContinueAction(_ sender: Any) {
        
        if RegisterModel.shared.images.count == 0{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgImage, control: ["OK"], topController: self)
        }else if RegisterModel.shared.images.count < 2{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kMsgSelectImgCount, control: ["OK"], topController: self)
        }else{
            pushToLoc()
        }
        
    }
    
    func pushToLoc(){
        let vc = LocationVC.getVC(.Main)
        self.push(vc)
    }
}


extension PhotoVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestClcCell
        if indexPath.row < 6{
            if selectedPhots.count > indexPath.row{
                cell.imgUser.image = selectedPhots[indexPath.row]
                cell.imgAddIcon.isHidden = true
                cell.btnDeleteImg.isHidden = false
            }else{
                cell.imgUser.image = UIImage(named: "imgBg")
                cell.btnDeleteImg.isHidden = true
                cell.imgAddIcon.isHidden = false
            }
        }
        
        cell.imgDelete = { [weak self] btn in
            
            self?.selectedPhots.remove(at: indexPath.row)
            self?.photoClcVw.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        //imagePicker.maximumSelectionsAllowed = 6
        let count = (6 - selectedPhots.count)
        imagePicker.maximumSelectionsAllowed = count
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        imagePicker.view.backgroundColor = .white
        if selectedPhots.count < 6{
           present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: ((photoClcVw.frame.size.width) / 3) - 10, height: 132)
        }
    
}


extension PhotoVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        //Save Images, update UI
       
        print("sdd",assets.count)
        print("UtilityManager.shared.getAssetThumbnail(assets: assets):-",getAssetThumbnail(assets: assets).count)
        
        for img in getAssetThumbnail(assets: assets){
            selectedPhots.append(img)
        }
        
        //selectedPhots =
        RegisterModel.shared.images.removeAll()
        
        for img in selectedPhots{
            guard let data = img.jpegData(compressionQuality: 0.75)else {return}
            RegisterModel.shared.images.append(data)
        }
        print("RegisterModel.shared.images:-",RegisterModel.shared.images.count)
        photoClcVw.reloadData()
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
