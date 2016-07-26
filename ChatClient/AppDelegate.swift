//
//  AppDelegate.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("qGxUAAQM3JFugLV9P0iMCXYzClVc9RgWsEeYaZQY", clientKey: "lx1nB7k1Xkc5oKoCJg1b3opMPI5uImznZVvXINMc")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                     openURL: url,
                                                                     sourceApplication: sourceApplication,
                                                                     annotation: annotation)
    }
    
    //Make sure it isn't already declared in the app delegate (possible redefinition of func error)
    func applicationDidBecomeActive(application: UIApplication) {
        
        FBSDKAppEvents.activateApp()
    }
}
