//
//  FineticApp.swift
//  Finetic
//
//  Created by Tapiwa on 2021-02-22.
//

import SwiftUI
import Firebase

@main
struct FineticApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ResolveApplication()
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Firebase...")
        FirebaseApp.configure()
        return true
    }
}

