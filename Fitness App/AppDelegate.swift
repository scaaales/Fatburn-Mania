//
//  AppDelegate.swift
//  Fitness App
//
//  Created by scales on 12/26/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	static var shared: AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		IQKeyboardManager.shared.enabledDistanceHandlingClasses.append(SignInViewController.self)
		return true
	}

}

