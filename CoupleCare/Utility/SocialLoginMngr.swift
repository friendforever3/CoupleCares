//
//  SocialLoginMngr.swift
//  Tic Tac Toe
//
//  Created by Surinder on 02/12/19.
//  Copyright © 2019 Surinder. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin

class SocialLoginMngr: NSObject  {
    
    static let shared = SocialLoginMngr()
    
    var vw = UIView()
    
    func siginWithGoogle(view:UIView,ViewController:UIViewController){
       
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: ViewController) { user, error in
            guard error == nil else { return }
            
            guard let user = user else { return }

            print("user:-",user.profile)
            
                let emailAddress = user.profile?.email

                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName

                let profilePicUrl = user.profile?.imageURL(withDimension: 320)

            // If sign in succeeded, display the app's main content View.
          }
        
    }
    
    
    
   //MARK:- Facebook Login
    
    func signinWithFacebook(controller:UIViewController){
            let loginManager = LoginManager()
            loginManager.logOut()
            loginManager.logIn(permissions: ["public_profile", "email"], from: controller) { (result,error) in
                   if let error = error {
                      print(error.localizedDescription)
                    return
                }
                let result = result
                print("result:-",result)
                debugPrint(result)
                print(AccessToken.current?.tokenString ?? "")
                
                let token = AccessToken.current?.tokenString
                let params = ["fields": "first_name, last_name, email,picture.type(large)"]
                let graphRequest = GraphRequest(graphPath: "me", parameters: params, tokenString: token, version: nil, httpMethod: .get)
                graphRequest.start { (connection, result, error) in

                    if let err = error {
                        print("Facebook graph request error: \(err)")
                    } else {
                        print("Facebook graph request successful!")

                        guard let json = result as? NSDictionary else { return }
                        if let email = json["email"] as? String {
                            print("\(email)")
                        }
                        if let firstName = json["first_name"] as? String {
                            print("\(firstName)")
                        }
                        if let lastName = json["last_name"] as? String {
                            print("\(lastName)")
                        }
                        if let id = json["id"] as? String {
                            print("\(id)")
                        }
                    }
                }
                
                
                /*
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                       Auth.auth().signIn(with: credential) { (authResult, error) in
                         if let error = error {
                           // ...
                            print(error.localizedDescription)
                           return
                         }
                
                        print("auth user id",Auth.auth().currentUser?.uid ?? "")
                        UtilityManager.userId = Auth.auth().currentUser?.uid ?? ""
                        var imgUrl = String()
                        if authResult?.user.photoURL != nil{
                            if let url = authResult?.user.photoURL{
                                imgUrl = "\(url)"
                            }else{
                                imgUrl = ""
                            }
                        }else{
                            imgUrl = ""
                        }
                        
                        UserViewModel.shared.facebookSigin(email: authResult?.user.email ?? "", fullName: authResult?.user.displayName ?? "", view: controller.view, imgUrl: "\(imgUrl)", userId: authResult?.user.uid ?? "") { (success) in
                            UtilityManager().navigateWithFadeTransiton("HomeVC", view: controller)
                        }
                        
                        print(UtilityManager.userId)
    //                    print("user id",authResult?.user.uid)
    //                    print(authResult?.user.email)
    //                    print(authResult?.user.displayName)
    //                    print(authResult?.user.photoURL)
                        }
                     */
                
                   }
            
            
        }

}
