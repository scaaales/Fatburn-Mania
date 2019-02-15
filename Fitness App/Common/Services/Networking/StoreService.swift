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
	case buyStoreItems(token: String, productId: Int)
}

extension StoreService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		switch self {
		case .getStoreItems:
			return "/store_items"
		case .buyStoreItems:
			return "/user/buy_store_item"
		}
	}
	
	var method: Method {
		switch self {
		case .getStoreItems:
			return .get
		case .buyStoreItems:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .getStoreItems:
			return .requestPlain
		case .buyStoreItems(_, let productId):
			return .requestParameters(parameters: ["store_item_id": productId],
									  encoding: JSONEncoding.default)
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					  "Accept": "application/json"]
		
		switch self {
		case .getStoreItems(let token),
			 .buyStoreItems(let token, _):
			headers["Authorization"] = "Bearer \(token)"
		}
		
		return headers
	}
	
}
