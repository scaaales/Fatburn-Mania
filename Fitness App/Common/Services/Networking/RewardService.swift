//
//  RewardService.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum RewardService {
	case getMeasurementsReward(token: String)
	case getWorkoutReward(token: String)
}

extension RewardService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		var path = "/user/reward/"
		switch self {
		case .getMeasurementsReward:
			path += "measures"
		case .getWorkoutReward:
			path += "workout_day"
		}
		return path
	}
	
	var method: Method { return .get }
	
	var sampleData: Data { return .init() }
	
	var task: Task { return .requestPlain }
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getMeasurementsReward(let token),
			 .getWorkoutReward(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
	
}
