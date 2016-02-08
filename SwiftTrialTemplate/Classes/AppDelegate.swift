//
//  AppDelegate.swift
//  SwiftTrialTemplate
//
//  Created by MasahiroFukuda on 2016/01/17.
//  Copyright (c) 2016 MasahiroFukuda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        AppLogger.sharedInstance.setup()
        NSSetUncaughtExceptionHandler { (exception) -> Void in
            ELog("[name]\(exception.name) [reason]\(exception.reason) [userInfo]\(exception.userInfo)\n\(exception.callStackSymbols.joinWithSeparator("\n"))")
        }
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        ILog("[CFBundleIdentifier]\(infoDictionary?["CFBundleIdentifier"] as! String) [CFBundleVersion]\(infoDictionary?["CFBundleVersion"] as! String) [CFBundleShortVersionString]\(infoDictionary?["CFBundleShortVersionString"] as! String)")
        ILog("[devide name]\(UIDevice.currentDevice().name) [model]\(UIDevice.currentDevice().model) [systemName]\(UIDevice.currentDevice().systemName) [localizedModel]\(UIDevice.currentDevice().localizedModel) [systemVersion]\(UIDevice.currentDevice().systemVersion)")
        DLog("[NSHomeDirectory]\(NSHomeDirectory())")
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let navi = UINavigationController(rootViewController: MainViewController())
        navi.view.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        ILog("\(__FUNCTION__)")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        ILog("\(__FUNCTION__)")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        ILog("\(__FUNCTION__)")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        ILog("\(__FUNCTION__)")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        ILog("\(__FUNCTION__)")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

