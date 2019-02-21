//
//  FitnessApi+auth.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya
import KeychainSwift
import Result

extension FitnessApi {
	class Auth: BaseApi {
		private let provider = MoyaProvider<AuthService>(plugins: [NetworkActivityPlugin.default])
		
		// register
		typealias OnSuccessRegisterCompletion = (_ message: String) -> Void
		
		func registerUserWith(name: String, phone: String,
							  email: String, password: String,
							  onComplete: @escaping () -> Void,
							  onSuccess: @escaping OnSuccessRegisterCompletion,
							  onError: @escaping OnErrorCompletion) {
			request = provider.request(.register(name: name,
												 phone: phone,
												 email: email,
												 password: password))
			{ result in
				onComplete()
				BaseApi.handleResult(result,
									 onSuccess:
					{ json in
						self.handleRegisterJSON(json, onSuccess: onSuccess, onError: onError)
				}, onError: onError)
			}
			
		}
		
		private func handleRegisterJSON(_ json: JSON,
										onSuccess: @escaping OnSuccessRegisterCompletion,
										onError: @escaping OnErrorCompletion) {
			if let success = json["success"] as? Bool {
				if success {
					if let successText = json["message"] as? String {
						onSuccess(successText)
					}
				} else {
					if let error = json["error"] as? [String: [String]],
						let errorMessages = error["email"] {
						onError(errorMessages[0])
					}
				}
			}
		}
		
		// login
		typealias OnSuccessLoginCompletion = (_ accessToker: String, _ expiresIn: Int) -> Void
		
		func login(email: String, password: String,
				   onComplete: @escaping () -> Void,
				   onSuccess: @escaping OnSuccessLoginCompletion,
				   onError: @escaping OnErrorCompletion) {
			request = provider.request(.login(email: email, password: password)) { result in
				onComplete()
				BaseApi.handleResult(result,
									 onSuccess:
					{ json in
						if let errorText = json["error"] as? String {
							onError(errorText)
						} else if let token = json["access_token"] as? String,
							let expiresIn = json["expires_in"] as? Int {
							onSuccess(token, expiresIn)
						}
				}, onError: onError)
			}
		}
		
		// logout
		func logout(token: String,
					onComplete: @escaping () -> Void,
					onSuccess: @escaping () -> Void,
					onError: @escaping OnErrorCompletion) {
			request = provider.request(.logout(token: token)) { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { _ in
					onSuccess()
				}, onError: onError)
			}
		}
		
	}
}
