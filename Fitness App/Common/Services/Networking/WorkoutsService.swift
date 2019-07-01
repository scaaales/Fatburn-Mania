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
	case uploadPhoto(photoData: Data, token: String, workoutId: Int)
	case trainingComplete(workoutId: Int, token: String)
	
	case getWorkoutOfTheDay(token: String)
	case workoutOfTheDayComplete(token: String)
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
		case .trainingComplete(let workoutId, _):
			path += "workout_items/\(workoutId)/training_complete"
		case .uploadPhoto(_, _, let workoutId):
			path += "workout_items/\(workoutId)/upload_photo"
		case .getWorkoutOfTheDay:
			path += "workout_day"
		case .workoutOfTheDayComplete:
			path += "workout_day/training_complete"
		}
		return path
	}
	
	var method: Method {
		switch self {
			case .getSeasons, .getWorkoutsFor, .getExercisesFor, .getWorkoutOfTheDay:
			return .get
		case .uploadPhoto, .trainingComplete, .workoutOfTheDayComplete:
			return .post
		}
	}
	
	var sampleData: Data { return .init() }
	
	var task: Task {
		switch self {
		case .getSeasons, .getWorkoutsFor, .getExercisesFor,
			 .getWorkoutOfTheDay, .trainingComplete, .workoutOfTheDayComplete:
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
			 .uploadPhoto(_, let token,_),
			 .trainingComplete(_, let token),
			 .getWorkoutOfTheDay(let token),
			 .workoutOfTheDayComplete(let token):
			headers["Authorization"] = "Bearer \(token)"
		}
		return headers
	}
	
}
