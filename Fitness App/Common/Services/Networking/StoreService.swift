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
	case buyStoreItem(token: String, productId: Int)
}

extension StoreService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		switch self {
		case .getStoreItems:
			return "/store_items"
		case .buyStoreItem:
			return "/user/buy_store_item"
		}
	}
	
	var method: Method {
		switch self {
		case .getStoreItems:
			return .get
		case .buyStoreItem:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .getStoreItems:
			return .requestPlain
		case .buyStoreItem(_, let productId):
			return .requestParameters(parameters: ["store_item_id": productId],
									  encoding: JSONEncoding.default)
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					  "Accept": "application/json"]
		
		switch self {
		case .getStoreItems(let token),
			 .buyStoreItem(let token, _):
			headers["Authorization"] = "Bearer \(token)"
		}
		
		return headers
	}
	
}
