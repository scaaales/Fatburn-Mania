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
	case editUserInfo(token: String, newUser: User)
	case editAvatar(token: String, data: Data)
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
		case .editUserInfo, .editAvatar:
			return path + "edit"
		}
	}
	
	var method: Method {
		switch self {
		case .getUserInfo, .getCoinsHistory:
			return .get
		case .editUserInfo, .editAvatar:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .getUserInfo, .getCoinsHistory:
			return .requestPlain
		case .editUserInfo(_, let user):
			return .requestJSONEncodable(user)
		case .editAvatar(_, let data):
			let avatarData = MultipartFormData(provider: .data(data), name: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
			return .uploadMultipart([avatarData])
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getUserInfo(let token),
			 .getCoinsHistory(let token),
			 .editUserInfo(let token, _),
			 .editAvatar(let token, _):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
