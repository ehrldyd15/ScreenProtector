//
//  AppDelegate.swift
//  ScreenProtector
//
//  Created by MetLife on 6/14/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    lazy var screenProtectorKit = {
        return ScreenProtectorKit(window: window)
    }()
    
    /*
     if you use SeneDelegate, set window on SeneDelegate.
     But if not, follow the instructions below

     1. Remove SceneDelegate.swift file
     2. Remove Application Scene Manifest from Info.plist file
     3. Add var window: UIWindow? to AppDelegate.swift
     4. Replace @main with @UIApplicationMain
     5. Remove UISceneSession Lifecycle ( functions ) in AppDelegate
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }
        
        self.window = window
        
        window.makeKeyAndVisible()

        let isRecording = screenProtectorKit.screenIsRecording()
        
        DispatchQueue.main.async {
            self.screenProtectorKit.configurePreventionScreenshot()
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        screenProtectorKit.disablePreventScreenshot()
        screenProtectorKit.enabledBlurScreen()
        screenProtectorKit.disableImageScreen()
        screenProtectorKit.disableColorScreen()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        screenProtectorKit.enabledPreventScreenshot()
        screenProtectorKit.disableBlurScreen()
        screenProtectorKit.enabledImageScreen(named: "LaunchImage")
        screenProtectorKit.enabledColorScreen(hexColor: "#ffffff")
    }

}

