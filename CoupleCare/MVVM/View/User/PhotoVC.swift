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
                cell.btnDeleteImg.isHidden = true
                cell.imgAddIcon.isHidden = false
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 6
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        imagePicker.view.backgroundColor = .white
        present(imagePicker, animated: true, completion: nil)
        
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
       
        selectedPhots = UtilityManager.shared.getAssetThumbnail(assets: assets)
        
        for img in selectedPhots{
            guard let data = img.jpegData(compressionQuality: 0.2)else {return}
            RegisterModel.shared.images.append(data)
        }
        
        photoClcVw.reloadData()
        print(assets.count)
        //Dismiss Controller
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
    
    
}
