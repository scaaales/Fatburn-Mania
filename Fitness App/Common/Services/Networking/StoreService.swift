//
//  StoreService.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum StoreService {
	case getStoreItems(token: String)
}

extension StoreService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		return "/api/store_items"
	}
	
	var method: Method { return .get }
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		return .requestPlain
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					  "Accept": "application/json"]
		
		switch self {
		case .getStoreItems(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		
		return headers
	}
	
}
