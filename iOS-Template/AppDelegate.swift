//
//  AppDelegate.swift
//  iOS-Template
//
//  Created by Markus Moltke on 23/04/2020.
//  Copyright © 2020 Markus Moltke. All rights reserved.
//

import UIKit

//Firebase
import Firebase

//Swifty JSON
import SwiftyJSON

//Appcenter
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public static var config : JSON!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let path = Bundle.main.path(forResource: "config", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        AppDelegate.config = JSON(parseJSON: jsonString!)
        
        if AppDelegate.config["firebase"].exists() {
            print("Configuring Firebase/Crashalytics")
            FirebaseApp.configure()
        }
        if AppDelegate.config["appcenterid"].exists() {
            print("Configuring AppCenter")
            MSAppCenter.start(AppDelegate.config["appcenterid"].string, withServices:[
              MSAnalytics.self,
              MSCrashes.self
            ])
        }
        return true
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

