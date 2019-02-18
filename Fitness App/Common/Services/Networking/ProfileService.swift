//
//  ProfileService.swift
//  Fitness App
//
//  Created by scales on 2/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum ProfileService {
	case getUserInfo(token: String)
	case getCoinsHistory(token: String)
}

extension ProfileService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		let path = "/user/"
		switch self {
		case .getUserInfo:
			return path + "info"
		case .getCoinsHistory:
			return path + "coins_history"
		}
	}
	
	var method: Method { return .get }
	
	var sampleData: Data { return .init() }
	
	var task: Task { return .requestPlain }
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getUserInfo(let token),
			 .getCoinsHistory(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
