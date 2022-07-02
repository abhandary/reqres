//
//  AppDelegate.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewModel = ReqResUsersViewModel(networkLoader: ReqResNetworkLoader(), dataStorage: ReqResDataStore())
    window?.rootViewController = ReqResUserTableViewController(viewModel: viewModel)
    window?.makeKeyAndVisible()
    return true
  }
}

