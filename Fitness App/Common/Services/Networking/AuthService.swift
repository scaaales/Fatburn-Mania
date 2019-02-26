//
//  AuthService.swift
//  Fitness App
//
//  Created by scales on 2/5/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum AuthService {
	case register(name: String, phone: String, email: String, password: String)
	case login(email: String, password: String)
	case resetPassword(email: String)
	case logout(token: String)
}

extension AuthService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		let path = "/auth/"
		switch self {
		case .register:
			return path + "register"
		case .login:
			return path + "login"
		case .resetPassword:
			return path + "forgot_password"
		case .logout:
			return path + "logout"
		}
	}
	
	var method: Method { return .post }
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case let .register(name, phone, email, password):
			return .requestParameters(parameters: [
				"name": name,
				"phone": phone,
				"email": email,
				"password": password
				], encoding: JSONEncoding.default)
		case let .login(email, password):
			return .requestParameters(parameters: [
				"email": email,
				"password": password
				], encoding: JSONEncoding.default)
		case .resetPassword(let email):
			return .requestParameters(parameters: [
				"email": email
				], encoding: JSONEncoding.default)
		case .logout:
			return .requestPlain
		}
	}
	
	var headers: [String: String]? {
		var headers = ["Content-type": "application/json",
					  "Accept": "application/json"]
		switch self {
		case .logout(let token):
			headers["Authorization"] = "Bearer \(token)"
		default:
			break
		}
		return headers
	}
	
}
