//
//  FitnessApi+profile.swift
//  Fitness App
//
//  Created by scales on 2/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Profile: BaseTokenApi {
		private let provider = MoyaProvider<ProfileService>(plugins: [NetworkActivityPlugin.default])
		
		private struct UserResponse: Decodable {
			let user: User
			let success: Bool
		}
		
		func getUserInfo(onComplete: @escaping () -> Void,
						 onSuccess: @escaping (User) -> Void,
						 onError: @escaping OnErrorCompletion) {
			request = provider.request(.getUserInfo(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result,
								  intoItemOfType: UserResponse.self,
								  onSuccess: { userResponse in
									onSuccess(userResponse.user)
				}, onError: onError)
			})
		}
		
		private struct CoinsHistoryResponse: Decodable {
			let coinsHistory: [CoinsHistory]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case coinsHistory = "coins_items"
				case success
			}
		}
		
		func getCoinsHistory(onComplete: @escaping () -> Void,
							 onSuccess: @escaping ([CoinsHistory]) -> Void,
							 onError: @escaping OnErrorCompletion) {
			request = provider.request(.getCoinsHistory(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result,
								  intoItemOfType: CoinsHistoryResponse.self,
								  onSuccess: { coinsHistoryResponse in
									onSuccess(coinsHistoryResponse.coinsHistory)
				}, onError: onError)
			})
		}
		
	}
}
