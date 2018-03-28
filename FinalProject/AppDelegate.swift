//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Avila, Colton C on 3/20/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FacebookLogin
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            //common error when user click cancel instead of sign in
            print("We have sign-in error: \(error)")
        } else {
            print("Our user signed in! \(user)")
        }
    }
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        if (configureError != nil) {
            print("Have error \(configureError)")
        }
        //add the declaration here for sign in
        GIDSignIn.sharedInstance().delegate = self
        
        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Old facebook login code
        //return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    //handle incoming URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication =  options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        
        let googleHandler = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation )
        
        let facebookHandler = SDKApplicationDelegate.shared.application(app, open:url, options: options)
        //old fb handler URL key
        //let facebookHandler = FBSDKApplicationDelegate.sharedInstance().application (app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return googleHandler || facebookHandler
    }
    
    //Old GoogleCode
    //func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        //return GIDSignIn.sharedInstance().handle(url as URL!, sourceApplication: sourceApplication, annotation: annotation)
    //}
    
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

