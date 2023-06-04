//
//  AppDelegate.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL ?? "hi")
        
        do {
            _ = try Realm()
        }catch {
            print("Error initialising new realm with error: \(error)")
        }
        
        // Setting up the navigation bar
        let newNavBarAppearance = NavigationBarConfigurer.customNavBarAppearance()
        let newNavBarAppearanceBlur = NavigationBarConfigurer.customNavBarAppearanceBlur()
        
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = newNavBarAppearance
        appearance.standardAppearance = newNavBarAppearanceBlur
        
        NavigationBarConfigurer.customRightBarButtonItem()
        NavigationBarConfigurer.customNavigationBar()
        return true
    }
}
