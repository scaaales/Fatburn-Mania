//
//  DiaryService.swift
//  Fitness App
//
//  Created by scales on 2/19/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum DiaryService {
	case getMeasurements(token: String, date: String?, limit: Int?, offset: Int?)
	case addMeasurements(token: String, measurements: Measurements)
	case getTrainingDay(token: String, date: String)
}

extension DiaryService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		switch self {
		case .getMeasurements,
			 .addMeasurements:
			return "/user/measures"
		case .getTrainingDay:
			return "/user/training_day"
		}
	}
	
	var method: Method {
		switch self {
		case .getMeasurements,
			 .getTrainingDay:
			return .get
		case .addMeasurements:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case let .getMeasurements(_, date, limit, offset):
			var params: [String: Any] = [:]
			params["date"] = date
			params["limit"] = limit
			params["offset"] = offset
			return .requestParameters(parameters: params, encoding: URLEncoding.default)
		case let .addMeasurements(_, measurements):
			return .requestJSONEncodable(measurements)
		case .getTrainingDay(_, let date):
			return .requestParameters(parameters: ["date": date], encoding: URLEncoding.default)
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getMeasurements(let token, _, _, _),
			 .addMeasurements(let token, _),
			 .getTrainingDay(let token, _):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
