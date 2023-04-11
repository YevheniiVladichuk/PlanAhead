//
//  AppDelegate.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setting up the navigation bar
        let newNavBarAppearance = customNavBarAppearance()
        let newNavBarAppearanceBlur = customNavBarAppearanceBlur()
       
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = newNavBarAppearance
        appearance.standardAppearance = newNavBarAppearanceBlur
        
        return true
    }
    
    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = UIColor(named: K.colors.barAppearanceColor)
        
        // Apply white colored normal and large titles.
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        return customNavBarAppearance
    }
    
    func customNavBarAppearanceBlur() -> UINavigationBarAppearance {
        let blurAppearance = UINavigationBarAppearance()
        blurAppearance.configureWithTransparentBackground()
        blurAppearance.backgroundColor = UIColor(named: K.colors.barAppearanceColor)?.withAlphaComponent(0.95)
        blurAppearance.backgroundEffect = UIBlurEffect(style: .extraLight)
        
        // Apply white colored normal and large titles.
        blurAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        return blurAppearance
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

