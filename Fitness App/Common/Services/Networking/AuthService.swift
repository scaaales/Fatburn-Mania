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
}

extension AuthService: TargetType {
	var baseURL: URL { return URL(string: "https://fitness-backend.ridex.tech")! }
	
	var path: String {
		switch self {
		case .register:
			return "/api/auth/register"
		}
	}
	
	var method: Method {
		switch self {
		case .register: return .post
		}
	}
	
	var sampleData: Data {
		return .init()
	}
	
	var task: Task {
		switch self {
		case let .register(name, phone, email, password):
			return .requestParameters(parameters: [
				"name": name,
				"phone": phone,
				"email": email,
				"password": password
				], encoding: JSONEncoding.default)
		}
	}
	
	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}
	
	
}
