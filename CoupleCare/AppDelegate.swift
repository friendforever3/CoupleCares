//
//  AppDelegate.swift
//  CoupleCare
//
//  Created by Deeksha Sharma on 21/10/21.
//

import UIKit
import IQKeyboardManager
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FirebaseMessaging
import Firebase

let signInConfig = GIDConfiguration.init(clientID: "97500273559-q117jr5hqk21fg4l2ho9paa5n2lv1ps4.apps.googleusercontent.com")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        if(url.scheme!.isEqual("fb239160444286729")) {
            
            return ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
            
        }else{
            return GIDSignIn.sharedInstance.handle(url)
        }
        
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

//MARK:- Firebase Push Notification Method
extension AppDelegate:UNUserNotificationCenterDelegate,MessagingDelegate{
    
    func pushNotificationPermission(_ application: UIApplication){
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
           
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
           // Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //  print("Firebase registration token: \(fcmToken)")
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
       
       // UtilityMangr.shared.pushDeviceToken = fcmToken ?? ""
    
        print("fcm token:-",fcmToken ?? "")
        //saveDeviceToken(token: fcmToken)
        //UserDefaults.standard.set(fcmToken, forKey: "token")
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //  print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
       print("userInfo:-",userInfo)

        //        // Print message ID.
//        print("gcm.notification.event_type: \(userInfo["gcm.notification.event_type"])")
//        print("event_type:-",userInfo["event_type"])
//        print("data:-",userInfo["data"])
//        print("gcm.notification.data:-",userInfo["gcm.notification.data"])
        
        
//        if userInfo["noy"] as? String == "SONG_REQ_SEND"{
//            let Vc:CallView = CallView.instance
//            Vc.show()
//        }
        completionHandler([.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("userInfo:-",userInfo)
        // Print message ID.
        // Print full message.
        if userInfo["event_type"] as? String == "SONG_REQ_SEND"{
            if userInfo["noy"] as? String == "SONG_REQ_SEND"{
                let Vc:CallView = CallView.instance
                Vc.show()
            }
            
        }
        print(userInfo )
        completionHandler()
    }
    
}
