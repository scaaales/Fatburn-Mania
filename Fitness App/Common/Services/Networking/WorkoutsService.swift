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
	case uploadPhoto(_ photoData: Data, token: String, workoutId: Int)
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
		case .uploadPhoto(_, _, let workoutId):
			path += "workout_items/\(workoutId)/upload_photo"
		}
		return path
	}
	
	var method: Method {
		switch self {
			case .getSeasons, .getWorkoutsFor, .getExercisesFor, .getWorkoutOfTheDay:
			return .get
		case .uploadPhoto:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .getSeasons, .getWorkoutsFor, .getExercisesFor, .getWorkoutOfTheDay:
			return .requestPlain
		case .uploadPhoto(let data, _, _):
			let photoData = MultipartFormData(provider: .data(data), name: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
			return .uploadMultipart([photoData])
		}
	}
	
	var headers: [String : String]? {
		var headers = ["Content-type": "application/json",
					   "Accept": "application/json"]
		switch self {
		case .getSeasons(let token),
			 .getWorkoutsFor(_, let token),
			 .getExercisesFor(_, let token),
			 .getWorkoutOfTheDay(let token),
			 .uploadPhoto(_, let token,_):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
