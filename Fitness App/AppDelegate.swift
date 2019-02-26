//
//  AppDelegate.swift
//  Fitness App
//
//  Created by scales on 12/26/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var pushNotificationService: PushNotificationService?
	
	static var shared: AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		IQKeyboardManager.shared.enabledDistanceHandlingClasses.append(SignInViewController.self)
		IQKeyboardManager.shared.enableAutoToolbar = false
		
		registerForPushNotifications()
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		// 1. Convert device token to string
		let tokenParts = deviceToken.map { data in
			return String(format: "%02.2hhx", data)
		}
		let token = tokenParts.joined()
		
		pushNotificationService = .init(deviceToken: token)
		pushNotificationService?.unreadNotificationsCount = UIApplication.shared.applicationIconBadgeNumber
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		// 1. Print out error if PNs registration not successful
		print("Failed to register for remote notifications with error: \(error)")
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
					 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		
	}
	
	private func registerForPushNotifications() {
		UNUserNotificationCenter.current().delegate = self
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
			(granted, error) in
			// 1. Check if permission granted
			guard granted else { return }
			// 2. Attempt registration for remote notifications on the main thread
			DispatchQueue.main.async {
				UIApplication.shared.registerForRemoteNotifications()
			}
		}
	}

}

extension AppDelegate: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.alert, .badge, .sound])
		pushNotificationService?.unreadNotificationsCount = 1
	}
}

