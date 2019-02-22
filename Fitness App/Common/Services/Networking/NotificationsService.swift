//
//  NotificationsService.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum NotificationsService {
	case registerNotifications(accessToken: String)
	case removeNotifictionsToken(accessToken: String)
	case getNotifications(accessToken: String)
}

extension NotificationsService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		var path = "/user/"
		switch self {
		case .registerNotifications:
			path += "register_notifications"
		case .removeNotifictionsToken:
			path += "remove_notifications"
		case .getNotifications:
			path += "notifications"
		}
		return path
	}
	
	var method: Method {
		switch self {
		case .registerNotifications,
			 .removeNotifictionsToken:
			return .post
		case .getNotifications:
			return .get
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task { return .requestPlain }
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .registerNotifications(let token),
			 .removeNotifictionsToken(let token),
			 .getNotifications(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
	
}
