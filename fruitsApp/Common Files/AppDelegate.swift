//
//  AppDelegate.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/15/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var stringWithLink = "متجر الفاكهة والخضار : في خطوات سهلة وقصيرة كل احتياجاتك تصل الي مكانك كما لوكنت انت تشتري بنفسك http://itunes.apple.com/app/id1539317993 "
    static var LocalUrl = "https://services-apps.net/fruits/public/api/"
    static var badge = [CAShapeLayer(),CAShapeLayer(),CAShapeLayer(),CAShapeLayer(),CAShapeLayer()]
    static var firstBadge = [true,true,true,true,true]
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if CashedData.getUserApiKey() == nil{
            CashedData.saveUserApiKey(token: "")
        }
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyDBTDTrEtqkxBMwTRa1Z2eeaaqOXpS4CeQ")
        GMSPlacesClient.provideAPIKey("AIzaSyDBTDTrEtqkxBMwTRa1Z2eeaaqOXpS4CeQ")
        FirebaseApp.configure()
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

