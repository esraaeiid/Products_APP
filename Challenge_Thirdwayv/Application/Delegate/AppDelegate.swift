//
//  AppDelegate.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Coordinator.instance.restart()
        
        return true
    }


}

