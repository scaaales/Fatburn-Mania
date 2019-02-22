//
//  FitnessApi+notifications.swift
//  Fitness App
//
//  Created by scales on 2/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Notifications: BaseTokenApi {
		private let provider = MoyaProvider<NotificationsService>(plugins: [NetworkActivityPlugin.default])
		
		private struct GetNotificationsResponse: Decodable {
			let notifications: [PushNotification]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case notifications = "user_notifications"
				case success
			}
		}
		
		func registerNotifications(deviceToken: String,
								   onComplete: @escaping () -> Void,
								   onSuccess: @escaping () -> Void,
								   onError: @escaping OnErrorCompletion) {
			request = provider.request(.registerNotifications(accessToken: token,
															  deviceToken: deviceToken), completion:
				{ result in
					onComplete()
					BaseApi.handleResult(result, onSuccess: { _ in
						onSuccess()
					}, onError: onError)
			})
		}
		
		func removeNotifictionsToken(deviceToken: String,
									 onComplete: @escaping () -> Void,
									 onSuccess: @escaping () -> Void,
									 onError: @escaping OnErrorCompletion) {
			request = provider.request(.removeNotificationsToken(accessToken: token,
																deviceToken: deviceToken), completion:
				{ result in
					onComplete()
					BaseApi.handleResult(result, onSuccess: { _ in
						onSuccess()
					}, onError: onError)
			})
		}
		
		func getNotifications(onComplete: @escaping () -> Void,
							  onSuccess: @escaping ([PushNotification]) -> Void,
							  onError: @escaping OnErrorCompletion) {
			request = provider.request(.getNotifications(accessToken: token),
									   completion:
				{ result in
					onComplete()
					BaseApi.mapResult(result,
									  intoItemOfType: GetNotificationsResponse.self, onSuccess:
						{ getNotificationsResponse in
							onSuccess(getNotificationsResponse.notifications)
					}, onError: onError)
			})
		}
	}
}
