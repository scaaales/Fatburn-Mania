//
//  FitnessApi+workouts.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Workouts: BaseTokenApi {
		private let provider = MoyaProvider<WorkoutsService>(plugins: [NetworkActivityPlugin.default])
		
		private struct SeasonsResponse: Decodable {
			let seasons: [Season]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case seasons = "workout_seasons"
				case success
			}
		}
		
		func getSeasons(onComplete: @escaping () -> Void,
						onSuccess: @escaping ([Season]) -> Void,
						onError: @escaping OnErrorCompletion) {
			request = provider.request(.getSeasons(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result, intoItemOfType: SeasonsResponse.self, onSuccess:
					{ seasonsResponse in
					onSuccess(seasonsResponse.seasons)
				}, onError: onError)
			})
		}
		
		private struct WorkoutsResponse: Decodable {
			fileprivate struct SeasonInWorkout: Decodable {
				let workouts: [Lesson]
				
				enum CodingKeys: String, CodingKey {
					case workouts = "workout_items"
				}
			}
			
			let success: Bool
			let seasonInWorkout: SeasonInWorkout
			
			enum CodingKeys: String, CodingKey {
				case seasonInWorkout = "workout_season"
				case success
			}
		}
		
		func getWorkoutsFor(seasonId: Int,
							onComplete: @escaping () -> Void,
							onSuccess: @escaping ([Lesson]) -> Void,
							onError: @escaping OnErrorCompletion) {
			request = provider.request(.getWorkoutsFor(seasonId: seasonId, token: token),
									   completion:
				{ result in
					onComplete()
					BaseApi.mapResult(result, intoItemOfType: WorkoutsResponse.self, onSuccess: { workoutsResponse in
						onSuccess(workoutsResponse.seasonInWorkout.workouts)
					}, onError: onError)
			})
		}
		
		private struct ExercisesResponse: Decodable {
			fileprivate struct WorkoutItem: Decodable {
				let exercises: [Exercise]
				
				enum CodingKeys: String, CodingKey {
					case exercises = "training_items"
				}
			}
			let workoutItem: WorkoutItem
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case workoutItem = "workout_item"
				case success
			}
		}
		
		func getExerciseFor(workoutId: Int,
							onComplete: @escaping () -> Void,
							onSuccess: @escaping ([Exercise]) -> Void,
							onError: @escaping OnErrorCompletion) {
			request = provider.request(.getExercisesFor(workoutId: workoutId, token: token),
									   completion:
				{ result in
					onComplete()
					BaseApi.mapResult(result, intoItemOfType: ExercisesResponse.self, onSuccess: { exercisesResponse in
						onSuccess(exercisesResponse.workoutItem.exercises)
					}, onError: onError)
			})
		}
		
		private struct WorkoutOfTheDayResponse: Decodable {
			let workoutOfTheDay: WorkoutOfTheDay
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case workoutOfTheDay = "workout_day_item"
				case success
			}
		}
		
		func uploadPhoto(_ data: Data,
						 workoutId: Int,
						 onComplete: @escaping () -> Void,
						 onSuccess: @escaping () -> Void,
						 onError: @escaping OnErrorCompletion) {
			request = provider.request(.uploadPhoto(photoData: data, token: token, workoutId: workoutId), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					if let success = json["success"] as? Bool, success {
						onSuccess()
					} else {
						onError("Something went wrong during photo sending. Please try again")
					}
				}, onError: onError)
			})
		}
		
		func trainingComplete(workoutId: Int,
							  onComplete: @escaping () -> Void,
							  onSuccess: @escaping (Int?) -> Void,
							  onError: @escaping OnErrorCompletion) {
			request = provider.request(.trainingComplete(workoutId: workoutId, token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					onSuccess(json["coins"] as? Int)
				}, onError: onError)
			})
		}
		
		func getWorkoutOfTheDay(onComplete: @escaping () -> Void,
								onSuccess: @escaping (WorkoutOfTheDay) -> Void,
								onError: @escaping OnErrorCompletion) {
			request = provider.request(.getWorkoutOfTheDay(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result, intoItemOfType: WorkoutOfTheDayResponse.self, onSuccess: {
					onSuccess($0.workoutOfTheDay)
				}, onError: onError)
			})
		}
		
		func workoutOfTheDayCompleted(onComplete: @escaping () -> Void,
									  onSuccess: @escaping (Int?) -> Void,
									  onError: @escaping OnErrorCompletion) {
			request = provider.request(.workoutOfTheDayComplete(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					onSuccess(json["coins"] as? Int)
				}, onError: onError)
			})
		}
	}
}
