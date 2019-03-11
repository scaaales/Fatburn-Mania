//
//  FitnessApi+profile.swift
//  Fitness App
//
//  Created by scales on 2/18/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya
import Result

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
		
		func updateUser(_ user: User,
						onComplete: @escaping () -> Void,
						onSuccess: @escaping (User) -> Void,
						onError: @escaping OnErrorCompletion) {
			request = provider.request(.editUserInfo(token: token, newUser: user),
									   completion: { result in
										onComplete()
										FitnessApi.Profile.handleUpdateUserResult(result,
																				  onComplete: onComplete,
																				  onSuccess: onSuccess,
																				  onError: onError)
			})
		}
		
		private static func handleUpdateUserResult(_ result: Result<Response, MoyaError>,
											onComplete: @escaping () -> Void,
											onSuccess: @escaping (User) -> Void,
											onError: @escaping OnErrorCompletion) {
			BaseApi.handleResult(result, onSuccess: { json in
				if let success = json["success"] as? Bool, success {
					BaseApi.mapResult(result, intoItemOfType: UserResponse.self,
									  onSuccess: { userResponse in
										onSuccess(userResponse.user)
					}, onError: onError)
				} else if let error = json["error"] as? [String: [String]],
					let errorMessages = error["email"] {
					onError(errorMessages[0])
				}
				
			}, onError: onError)
		}
		
		func updateAvatar(_ data: Data,
						  onComplete: @escaping () -> Void,
						  onSuccess: @escaping (User) -> Void,
						  onError: @escaping OnErrorCompletion) {
			request = provider.request(.editAvatar(token: token, data: data),
									   completion: { result in
										onComplete()
										FitnessApi.Profile.handleUpdateUserResult(result,
																				  onComplete: onComplete,
																				  onSuccess: onSuccess,
																				  onError: onError)
			})
		}
		
		func updateSteps(_ steps: Int,
						 onComplete: @escaping () -> Void,
						 onSuccess: @escaping (Int?) -> Void,
						 onError: @escaping OnErrorCompletion) {
			request = provider.request(.updateSteps(token: token, steps: steps), completion: { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					onSuccess(json["coins"] as? Int)
				}, onError: onError)
			})
		}
		
		private struct SongsResponse: Decodable {
			let songs: [Song]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case songs = "audio_items"
				case success
			}
		}
		
		func getSongs(onComplete: @escaping () -> Void,
					  onSuccess: @escaping ([Song]) -> Void,
					  onError: @escaping OnErrorCompletion) {
			request = provider.request(.getSongs(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result, intoItemOfType: SongsResponse.self, onSuccess: {
					onSuccess($0.songs)
				}, onError: onError)
			})
		}
		
		private struct VideosResponse: Decodable {
			let videos: [Video]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case videos = "video_library_items"
				case success
			}
		}
		
		func getVideos(onComplete: @escaping () -> Void,
					   onSuccess: @escaping ([Video]) -> Void,
					   onError: @escaping OnErrorCompletion) {
			request = provider.request(.getVideos(token: token), completion: { result in
				onComplete()
				BaseApi.mapResult(result, intoItemOfType: VideosResponse.self, onSuccess: {
					onSuccess($0.videos)
				}, onError: onError)
			})
		}
		
	}
}
