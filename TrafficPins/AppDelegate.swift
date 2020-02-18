//
//  AppDelegate.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if targetEnvironment(simulator)
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
                print("Documents Directory: \(documentsPath)")
            }
        #endif
        return true
    }
}

