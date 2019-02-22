//
//  NotificationsService.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum NotificationsService {
	case registerNotifications(accessToken: String, deviceToken: String)
	case removeNotificationsToken(accessToken: String, deviceToken: String)
	case getNotifications(accessToken: String)
}

extension NotificationsService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		var path = "/user/"
		switch self {
		case .registerNotifications:
			path += "register_notifications"
		case .removeNotificationsToken:
			path += "remove_notifications"
		case .getNotifications:
			path += "notifications"
		}
		return path
	}
	
	var method: Method {
		switch self {
		case .registerNotifications,
			 .removeNotificationsToken:
			return .post
		case .getNotifications:
			return .get
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .registerNotifications(_, let deviceToken),
			 .removeNotificationsToken(_, let deviceToken):
			return .requestParameters(parameters: [
				"token": deviceToken
				], encoding: JSONEncoding.default)
		default:
			return .requestPlain
		}
	 }
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .registerNotifications(let token, _),
			 .removeNotificationsToken(let token, _),
			 .getNotifications(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
	
}
