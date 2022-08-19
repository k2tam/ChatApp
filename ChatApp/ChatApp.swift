//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by k2 tam on 11/08/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


@main
struct ChatApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
                    .environmentObject(ContactsViewModel())
            }
        }
    }
}
