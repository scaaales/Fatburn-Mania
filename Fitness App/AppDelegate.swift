//
//  AppDelegate.swift
//  Fitness App
//
//  Created by scales on 12/26/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		var initialStoryboard: UIStoryboard
		if UserDefaults.standard.bool(forKey: .userDefaultKeyIsLogginedIn) {
			#warning("change to DiaryTab after backend login integrated")
			initialStoryboard = .loginStack
		} else {
			initialStoryboard = .loginStack
		}
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = initialStoryboard.instantiateInitialViewController()
		self.window?.makeKeyAndVisible()
		
		return true
	}

}

