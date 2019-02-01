//
//  AppDelegate.swift
//  Todoey
//
//  Created by Apok Developer on 1/29/19.
//  Copyright © 2019 Apok Developer. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Get the default Realm
        do {
            let _ = try Realm()
        } catch {
            print("Error initialising new realm \(error)")
        }
        
        return true
    }


}

