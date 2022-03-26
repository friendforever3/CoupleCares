//
//  VoiceCallVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 17/03/22.
//

import UIKit
import TwilioVoice

class VoiceCallVC: UIViewController {

    var grpId : String = ""
    var activeCall: Call? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwilioViewModel.shared.emptyVideoCallToken()
        getAccessToken(grpId: grpId)

    }
    
    @IBAction func btnCallEndAction(_ sender: Any) {
        //self.popVc()
        connectCall(with: TwilioViewModel.shared.getTwilioCallToken().token)
    }
    
    func connectCall(with token:String){
        
        let connectOptions = ConnectOptions(accessToken: token) { (builder) in
            //builder.roomName
            //builder.params = ["to": "bob"]
        }
        
        //TwilioVoiceSDK.connect(options: connectOptions, delegate: self)
        
        activeCall = TwilioVoiceSDK.connect(options: connectOptions, delegate: self)
    }

}

//MARK: Voice Call Delegate
extension VoiceCallVC : CallDelegate{
    
    func callDidStartRinging(call: Call) {
        print(#function)
    }
  
    func callDidConnect(call: Call) {
        print("connect connect")
    }
    
    func callDidFailToConnect(call: Call, error: Error) {
        print("Call failed to connect: \(error.localizedDescription)")
    }
    
    func callDidDisconnect(call: Call, error: Error?) {
        if let error = error {
            print("Call failed: \(error.localizedDescription)")
        } else {
            print("Call disconnected")
        }
    }
    
    
}

//MARK: API
extension VoiceCallVC{
    
    func getAccessToken(grpId:String){
        TwilioViewModel.shared.getAccessToken(type:"audio",grpId: grpId) { [weak self] (success,msg) in
            if success{
                self?.connectCall(with: TwilioViewModel.shared.getTwilioCallToken().token)
            }else{
                UtilityManager.shared.displayAlertWithCompletion(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController()) { (_) in
                    self?.popVc()
                }
            }
        }
    }
}
