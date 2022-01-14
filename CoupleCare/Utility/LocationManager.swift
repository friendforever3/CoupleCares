//
//  LocationManager.swift
//  CoupleCare
//
//  Created by Surinder kumar on 15/12/21.
//

import Foundation
import MapKit

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

/// Notification on update of location. UserInfo contains CLLocation for key "location"
let kLocationDidChangeNotification = "LocationDidChangeNotification"

class UserLocationManager: NSObject, CLLocationManagerDelegate {

    static let SharedManager = UserLocationManager()

    private var locationManager = CLLocationManager()

    var currentLocation : CLLocation?

    var delegate : LocationUpdateProtocol!

    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        guard currentLocation == newLocation else {return}
        let _ : NSDictionary = ["location" : currentLocation!]

        self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
        self.locationManager.stopUpdatingLocation()
          //  NSNotificationCenter.defaultCenter().postNotificationName(kLocationDidChangeNotification, object: self, userInfo: userInfo as [NSObject : AnyObject])
        
    }

}
