//
//  AppDelegate.swift
//  Todoey
//
//  Created by Onur İpekboyayan on 3.12.2018.
//  Copyright © 2018 Onur İpekboyayan. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
        let realm = try Realm()

            
        } catch {
            print("error initializing new realm, \(error)")
        }
 
        return true
    }
}

//    func applicationWillResignActive(_ application: UIApplication) {
//
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//
//        self.saveContext()
//    }

    // MARK: - Core Data stack
    
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }





