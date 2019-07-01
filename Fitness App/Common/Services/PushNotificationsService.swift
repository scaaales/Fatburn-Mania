//
//  PushNotificationsService.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class PushNotificationService {
	var unreadNotificationsCount: Int? {
		didSet {
			var userInfo: [String: Int]?
			if let count = unreadNotificationsCount {
				userInfo = ["value": count]
			}
			NotificationCenter.default.post(name: .notificationsCountChanged,
											object: self,
											userInfo: userInfo)
		}
	}
	
	var deviceToken: String
	
	init(deviceToken: String) {
		self.deviceToken = deviceToken
	}
}
