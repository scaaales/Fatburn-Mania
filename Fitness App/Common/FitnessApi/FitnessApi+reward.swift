//
//  FitnessApi+reward.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Reward: BaseTokenApi {
		private let provider = MoyaProvider<RewardService>(plugins: [NetworkActivityPlugin.default])
		
		func getMeasurementsReward(onComplete: @escaping () -> Void,
								   onSuccess: @escaping (Int?) -> Void,
								   onError: @escaping OnErrorCompletion) {
			request = provider.request(.getMeasurementsReward(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					onSuccess(json["coins"] as? Int)
				}, onError: onError)
			})
		}
		
		func getWorkoutReward(onComplete: @escaping () -> Void,
							  onSuccess: @escaping (Int?) -> Void,
							  onError: @escaping OnErrorCompletion) {
			request = provider.request(.getWorkoutReward(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					onSuccess(json["coins"] as? Int)
				}, onError: onError)
			})
		}
	
	}
}
