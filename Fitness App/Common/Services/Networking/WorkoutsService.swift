//
//  WorkoutsService.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum WorkoutsService {
	case getSeasons(token: String)
	case getWorkoutsFor(seasonId: Int, token: String)
	case getExercisesFor(workoutId: Int, token: String)
	case getWorkoutOfTheDay(token: String)
}

extension WorkoutsService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		var path = "/user/"
		switch self {
		case .getSeasons:
			path += "workout_seasons"
		case .getWorkoutsFor(let seasonId, _):
			path += "workout_seasons/\(seasonId)"
		case .getExercisesFor(let workoutId, _):
			path += "workout_items/\(workoutId)"
		case .getWorkoutOfTheDay:
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
		case .getSeasons(let token),
			 .getWorkoutsFor(_, let token),
			 .getExercisesFor(_, let token),
			 .getWorkoutOfTheDay(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
