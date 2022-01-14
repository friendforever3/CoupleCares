//
//  LocationVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit
import MapKit

class LocationVC: UIViewController{
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
    
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    
    @IBAction func btnContinueAction(_ sender: Any) {
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            RegisterModel.shared.lat = "\(currentLocation.coordinate.latitude)"
            RegisterModel.shared.long = "\(currentLocation.coordinate.longitude)"
            self.push()
        }
        
    }
    
    
    @IBAction func btnSkipAction(_ sender: Any) {
        RegisterModel.shared.lat = "\(0.0)"
        RegisterModel.shared.long = "\(0.0)"
        self.push()
    }
    
    func push(){
        register()
    }
    
}

//MARK: API
extension LocationVC{
    
    func register(){
        UserVM.shared.register { [weak self] (success, msg) in
            if success{
                 let vc = CoupleCaresTabbar.getVC(.CoupleCares)
                 self?.push(vc)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}


