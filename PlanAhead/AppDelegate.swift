//
//  AppDelegate.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let data = Data()
        data.name = "Jax"
        data.age = 30
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
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
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

