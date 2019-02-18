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
		
		private class UserResponse: Decodable {
			let user: User
			let success: Bool
		}
		
		func getUserInfo(token: String,
						 onComplete: @escaping () -> Void,
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
		
		func getCoinsHistory(token: String,
							 onComplete: @escaping () -> Void,
							 onSuccess: @escaping () -> Void,
							 onError: @escaping OnErrorCompletion) {
			request = provider.request(.getCoinsHistory(token: token), completion: { result in
				onComplete()
				BaseApi.handleResult(result,
									 onSuccess:
					{ json in
					print(json)
				}, onError: onError)
			})
		}
		
	}
}
