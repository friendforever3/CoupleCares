//
//  VideoCallVC.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/03/22.
//

import UIKit
import TwilioVideo
import AudioToolbox

class VideoCallVC: UIViewController {

    @IBOutlet weak var largeView: UIView!
    @IBOutlet weak var smallView: UIView!
    
    var localAudioTrack = LocalAudioTrack()
    var localDataTrack = LocalDataTrack()
    var localVideoTrack : LocalVideoTrack?
    var room: Room?
    var remoteView: VideoView?
    var localView:VideoView?
    var camera: CameraSource?
    
    var grpId : String = ""
    var otherUserId : String = ""
    
    var comingFrom : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        TwilioViewModel.shared.emptyVideoCallToken()
        getAccessToken(grpId: grpId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCameraPreview(on: smallView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnEndCallAction(_ sender: Any) {
        camera?.stopCapture()
        room?.disconnect()
        self.popVc()
    }
    

    func setupCameraPreview(on view: UIView) {
        // Use CameraSource to produce video from the device's front camera.
        if let camera = CameraSource(delegate: self),
            let videoTrack = LocalVideoTrack(source: camera) {

            // VideoView is a VideoRenderer and can be added to any VideoTrack.
            let renderer = VideoView(frame: view.bounds)
            // Add renderer to the video track
            videoTrack.addRenderer(renderer)
            self.localVideoTrack = videoTrack
            self.camera = camera
            localView = renderer
            localView?.contentMode = .scaleAspectFill
            view.addSubview(renderer)
        } else {
            print("Couldn't create CameraCapturer or LocalVideoTrack")
        }
        if let device = CameraSource.captureDevice(position: .front) {
            self.localView?.shouldMirror = (device.position == .front)
        camera?.startCapture(device: device)
        }
    }
    
    func connectCall(with token:String, grantToken:String) {
        print("token:-",token)
        
        let connectOptions = ConnectOptions(token: token) { (builder) in
            //builder.roomName = self.grpId
            //  builder.roomName = "606b336dba3a1a1c0f35f31f"//self.viewModel.queueInfo?.queId
            
            //            builder.isAutomaticSubscriptionEnabled = false
            if let audioTrack = self.localAudioTrack {
                builder.audioTracks = [ audioTrack ]
            }
            if let dataTrack = self.localDataTrack {
                builder.dataTracks = [ dataTrack ]
            }
            if let videoTrack = self.localVideoTrack {
                builder.videoTracks = [ videoTrack ]
            }
        }
        
        self.room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
    }

}

extension VideoCallVC: CameraSourceDelegate {
    func cameraSourceDidFail(source: CameraSource, error: Error) {
        print("Failed to connect to Camera Error: \(error.localizedDescription)")
    }
    
    func cameraSourceInterruptionEnded(source: CameraSource) {
        print("Camera Source Interuppted")
    }
    
    func cameraSourceWasInterrupted(source: CameraSource, reason: AVCaptureSession.InterruptionReason) {
        print("Camera Source Interuppted reason:\(reason)")
    }
}

extension VideoCallVC: LocalParticipantDelegate {
    
}

extension VideoCallVC: RoomDelegate {
    func roomDidConnect(room: Room) {
        // The Local Participant
        if let localParticipant = room.localParticipant {
            print("Local identity \(localParticipant.identity)")
            
            // Set the delegate of the local participant to receive callbacks
            localParticipant.delegate = self
        }
        
        //        if viewModel.fromView != .incomingCall{
        //            //viewModel.sendCallNotification()
        //        }
        if comingFrom != "Notification"{
            TwilioViewModel.shared.sendCall(grpId: self.grpId, otherUserId: self.otherUserId) { [weak self] (succes,msg) in
                if succes{
                    
                }else{
                    UtilityManager.shared.displayAlertWithCompletion(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController()) { (_) in
                        self?.popVc()
                    }
                }
            }
        }
        
        // Connected participants already in the room
        print("Number of connected Participants \(room.remoteParticipants.count)")
        
        // Set the delegate of the remote participants to receive callbacks
        for remoteParticipant in room.remoteParticipants {
            remoteParticipant.delegate = self
        }
    }
    
    func roomDidDisconnect(room: Room, error: Error?) {
        print("Disconnected from room \(room.name)")
    }
    
    func roomIsReconnecting(room: Room, error: Error) {
        print("Reconnecting to room \(room.name), error = \(String(describing: error))")
    }
    
    func roomDidReconnect(room: Room) {
        print("Reconnected to room \(room.name)")
    }
    
    func roomDidFailToConnect(room: Room, error: Error) {
        print("Failed to connect to room \(room.name) Error: \(error.localizedDescription)")
    }
}

extension VideoCallVC: RemoteParticipantDelegate {
    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        print ("Participant \(participant.identity) has joined Room \(room.name)")
        participant.delegate = self
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        print ("Participant \(participant.identity) has left Room \(room.name)")
//        AlertController.alert(title: AlertActions.alert, message: "Video call is ended by other user.", buttons: [AlertActions.ok]) { [weak self] (act, index) in
//            if (self?.viewModel.fromView == .queue) {
//                self?.navigateToAcceptRejectView()
//            }else{
//                self?.navigationController?.popViewController(animated: true)
//            }
//        }
       
        //AlertController.alert(title: AlertActions.alert, message: "Video call is ended by other user.")
        
    }
    
    func remoteParticipantSwitchedOnVideoTrack(participant: RemoteParticipant, track: RemoteVideoTrack) {
        
    }
    func remoteParticipantSwitchedOffVideoTrack(participant: RemoteParticipant, track: RemoteVideoTrack) {
        
    }
    
    func remoteParticipantDidEnableVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        //
    }
    
    func remoteParticipantDidDisableVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        
    }
    
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack,
                                  publication: RemoteVideoTrackPublication,
                                  participant: RemoteParticipant) {
        
        print("Participant \(participant.identity) added a video track.")
        if let videoCallView = self.largeView,
           let remoteView = VideoView(frame: videoCallView.bounds, delegate: self) {
            videoTrack.addRenderer(remoteView)
            videoCallView.insertSubview(remoteView, at: 0
            )//addSubview(remoteView)
            self.remoteView = remoteView
            self.remoteView?.contentMode = .scaleAspectFill
        }
    }
    
    
    // MARK: VideoViewDelegate
    
    // Lastly, we can subscribe to important events on the VideoView
    func videoViewDimensionsDidChange(view: VideoView, dimensions: CMVideoDimensions) {
        print("The dimensions of the video track changed to: \(dimensions.width)x\(dimensions.height)")
        view.setNeedsLayout()
        largeView?.setNeedsLayout()
    }
}

extension VideoCallVC: VideoViewDelegate {
    func updateRemoteViewLayout() {
        remoteView?.updateVideoSize(CMVideoDimensions.init(width: Int32(remoteView?.frame.size.width ?? 0) ,
                                                           height: Int32(remoteView?.frame.size.height ?? 0) ), orientation: VideoOrientation.up)
    }
    
    func videoViewDidReceiveData(view: VideoView) {
        print("Video did receive data")
        updateRemoteViewLayout()
    }
}


//MARK: API
extension VideoCallVC{
    
    func getAccessToken(grpId:String){
        TwilioViewModel.shared.getAccessToken(type:"video" ,grpId: grpId) { [weak self] (success,msg) in
            if success{
                self?.connectCall(with: TwilioViewModel.shared.getTwilioCallToken().token, grantToken: TwilioViewModel.shared.getTwilioCallToken().videoGrant)
            }else{
                UtilityManager.shared.displayAlertWithCompletion(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController()) { (_) in
                    self?.popVc()
                }
            }
        }
    }
    
    func sendCall(grpId:String,otherId:String){
        
    }
}
