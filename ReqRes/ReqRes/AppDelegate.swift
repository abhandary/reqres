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
    let tableViewController = ReqResUserTableViewController(viewModel: viewModel)
    let navController =  ReqResListNavigationController()
    navController.viewControllers = [tableViewController]
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    return true
  }
}

