//
//  AppDelegate.swift
//  EasyDraw
//
//  Created by 朱彦谕 on 2022/6/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let coordinator = MainCoordinator()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController()
        coordinator.navigationController = navVC
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
        coordinator.start()
        return true
    }


}

