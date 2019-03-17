//
//  AppDelegate.swift
//  ChatChat
//
//  Created by Daniel Earl on 12/03/2019.
//  Copyright © 2019 Daniel Earl. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        SVProgressHUD.show()

        Auth.auth().signIn(withEmail: "a@b.com", password: "123456") { (user, error) in

            if let displayError = error {
                print("Error authenticating Firebase, \(displayError)")
            } else {
                SVProgressHUD.dismiss()
            }

        }
        
        
        return true
    }

    


}

