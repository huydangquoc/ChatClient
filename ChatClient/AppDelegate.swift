//
//  AppDelegate.swift
//  ChatClient
//
//  Created by Dang Quoc Huy on 7/26/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("qGxUAAQM3JFugLV9P0iMCXYzClVc9RgWsEeYaZQY", clientKey: "lx1nB7k1Xkc5oKoCJg1b3opMPI5uImznZVvXINMc")
        return true
    }
}
