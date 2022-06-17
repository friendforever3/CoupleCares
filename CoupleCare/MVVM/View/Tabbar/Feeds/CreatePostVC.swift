//
//  CreatePostVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 18/10/21.
//

import UIKit
import IQKeyboardManager
import SwiftUI

class CreatePostVC: UIViewController {

    @IBOutlet weak var tfCaption: UITextView!
    @IBOutlet weak var tfLocation: TextFieldCustom!
    @IBOutlet weak var tfText: IQTextView!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgVideo: UIImageView!
    
    //Image Post
    @IBOutlet weak var tfImgLocation: TextFieldCustom!
    @IBOutlet weak var tfImgCaption: UITextView!
    
    //Video Post
    @IBOutlet weak var tfVideoLocation: TextFieldCustom!
    @IBOutlet weak var tfVideoCaption: UITextView!
    
    var fileData : Data?
    var delegate : FeedRefreshDelegate? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnImagePickerAction(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
               //here is the image
            self.imgPost.isHidden = false
            self.fileData = image.jpegData(compressionQuality: 0.75)
            self.imgPost.image = image
    
        }
    }

    @IBAction func btnVideoPickerAction(_ sender: Any) {
        ImagePickerManager().pickVideo(self, videoAllow: true) { (videourl) in
            print("media url:-",videourl)
            
            if let thumbnailImage = UtilityManager.shared.getThumbnailImage(forUrl: videourl){
                self.imgVideo.isHidden = false
                self.imgVideo.image = thumbnailImage
                self.fileData = try? Data(contentsOf: videourl)
                
                Indicator.shared.start("Compresssing a video..please wait!")
                SKVideoCompressor.compressVideoWithQuality(presetName: "AVAssetExportPresetMediumQuality", inputURL: videourl as NSURL, completionHandler: { (outputUrl) in
                    Indicator.shared.stop()
                    let compressSize = NSData(contentsOf: outputUrl as URL)
                    let sizeinMB = ByteCountFormatter.string(fromByteCount: Int64((compressSize?.length)!), countStyle: .file)
                    self.fileData = compressSize! as Data
                    print("sizeInMB:-",sizeinMB)
                    
                })
                
            }
        }
    }
    
    @IBAction func btnTextPostAction(_ sender: Any) {
        if tfText.text.isEmptyOrWhitespace(){
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kTextEmpty, control: [AppConstant.kOk], topController: self)
        }else if tfLocation.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyLocation, control: [AppConstant.kOk], topController: self)
        }else if tfCaption.text.isEmptyOrWhitespace(){
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyCaption, control: [AppConstant.kOk], topController: self)
        }else{
            postData(type: "text", text: tfText.text ?? "", loc: tfLocation.text ?? "", caption: tfCaption.text ?? "", fileData: nil)
        }
    }
    
    @IBAction func btnImgPostAction(_ sender: Any) {
        if tfImgLocation.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyLocation, control: [AppConstant.kOk], topController: self)
        }else if tfImgCaption.text.isEmptyOrWhitespace(){
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyCaption, control: [AppConstant.kOk], topController: self)
        }else if fileData == nil{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kSelectImage, control: [AppConstant.kOk], topController: self)
        }else{
            postData(type: "image", text: "", loc: tfImgLocation.text ?? "", caption: tfImgCaption.text ?? "", fileData: self.fileData)
        }
    }
    
    @IBAction func btnVideoPostAction(_ sender: Any) {
        if tfVideoLocation.text?.isEmptyOrWhitespace() ?? false{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyLocation, control: [AppConstant.kOk], topController: self)
        }else if tfVideoCaption.text.isEmptyOrWhitespace(){
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEmptyCaption, control: [AppConstant.kOk], topController: self)
        }else if fileData == nil{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kSelectVideo, control: [AppConstant.kOk], topController: self)
        }else{
            postData(type: "video", text: "", loc: tfVideoLocation.text ?? "", caption: tfVideoCaption.text ?? "", fileData: self.fileData)
        }
    }
    
    
    

}

//MARK: API
extension CreatePostVC{
    
    func postData(type:String,text:String,loc:String,caption:String,fileData:Data?){
        FeedViewModel.shared.createFeed(userid: UtilityManager.shared.userDecodedDetail().id, type: type, text: text, location: loc, caption: caption, fileData: fileData){ [weak self] (success,msg) in
            if success{
                self?.delegate?.didRefreshFeed()
                UtilityManager.shared.displayAlertWithCompletion(title: "", message: msg, control: ["OK"], topController: self ?? UIViewController()) { (_) in
                    self?.popVc()
                }
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
    }
    
}
