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
		
		func getSeasons(onComplete: @escaping () -> Void,
						onSuccess: @escaping ([Season]) -> Void,
						onError: @escaping OnErrorCompletion) {
			request = provider.request(.getSeasons(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					print(json)
				}, onError: onError)
			})
		}
		
		func getWorkoutsFor(seasonId: Int,
							onComplete: @escaping () -> Void,
							onSuccess: @escaping ([Lesson]) -> Void,
							onError: @escaping OnErrorCompletion) {
			request = provider.request(.getWorkoutsFor(seasonId: seasonId, token: token),
									   completion: { result in
										onComplete()
										BaseApi.handleResult(result, onSuccess: { json in
											print(json)
										}, onError: onError)
			})
		}
		
		func getExerciseFor(workoutId: Int,
							onComplete: @escaping () -> Void,
							onSuccess: @escaping ([Exercise]) -> Void,
							onError: @escaping OnErrorCompletion) {
			request = provider.request(.getExercisesFor(workoutId: workoutId, token: token),
									   completion: { result in
										onComplete()
										BaseApi.handleResult(result, onSuccess: { json in
											print(json)
										}, onError: onError)
			})
		}
		
		func getWorkoutOfTheDay(onComplete: @escaping () -> Void,
								onSuccess: @escaping (WorkoutOfTheDay) -> Void,
								onError: @escaping OnErrorCompletion) {
			request = provider.request(.getWorkoutOfTheDay(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					print(json)
				}, onError: onError)
			})
		}
	}
}
