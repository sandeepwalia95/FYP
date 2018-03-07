//
//  AppDelegate.swift
//  FYP
//
//  Created by Sandeep Walia on 27/01/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        let hasLaunchedKey = "HasLaunched"
        let hasLaunched = defaults.bool(forKey: hasLaunchedKey)
        
        if !hasLaunched {
            defaults.set(true, forKey: hasLaunchedKey)
            
            defaults.set("Walking", forKey: "actOne")
            defaults.set("Relax", forKey: "actTwo")
            defaults.set("Friends", forKey: "actThree")
            defaults.set("Alcohol", forKey: "actFour")
            defaults.set("Exercise", forKey: "actFive")
            defaults.set("Reading", forKey: "actSix")
            defaults.set("College", forKey: "actSeven")
            defaults.set("Shopping", forKey: "actEight")
            defaults.set("Family", forKey: "actNine")
            defaults.set("Party", forKey: "actTen")
            defaults.set("Movie", forKey: "actEleven")
            defaults.set("Eat out", forKey: "actTwelve")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

