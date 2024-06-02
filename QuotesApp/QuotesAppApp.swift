//
//  QuotesAppApp.swift
//  QuotesApp
//
//  Created by Eren on 31.05.2024.
//

import SwiftUI
import Firebase

@main
struct QuotesAppApp: App {
    @StateObject var quotesFactory = QuotesFactory()

    init() {
        // Ensure Firebase is configured at the start of the app
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(quotesFactory: quotesFactory)  // Updated to use `quotesFactory`
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // No need to call FirebaseApp.configure() here, as it's already called in the App struct
    return true
  }
}

