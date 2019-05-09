//
//  AppDelegate.swift
//  Todoey   
//
//  Created by ccztr on 2/18/19.
//  Copyright © 2019 Chacer. All rights reserved.
//  Updated 5/09/2019

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      //    print(Realm.Configuration.defaultConfiguration.fileURL!) // path to Default.realm
      //  print("Realm Config Description: \(Realm.Configuration.defaultConfiguration.description)") // Full configuration string
        
        do {
            _ = try Realm()  // let realm = try Realm()
        } catch {
            print("Error initializing RealmSwift \(error)")
        }

        return true
    }
} // end of AppDelegate class

