//
//  DiaryService.swift
//  Fitness App
//
//  Created by scales on 2/19/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum DiaryService {
	case getMeasurements(token: String, date: String?, limit: Int?)
	case addMeasurements(token: String, measurements: Measurements)
}

extension DiaryService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String { return "/user/measures" }
	
	var method: Method {
		switch self {
		case .getMeasurements:
			return .get
		case .addMeasurements:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case let .getMeasurements(_, date, limit):
			var params: [String: Any] = [:]
			params["date"] = date
			params["limit"] = limit
			return .requestParameters(parameters: params, encoding: URLEncoding.default)
		case let .addMeasurements(_, measurements):
			return .requestJSONEncodable(measurements)
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getMeasurements(let token, _, _),
			 .addMeasurements(let token, _):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
