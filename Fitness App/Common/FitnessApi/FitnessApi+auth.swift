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
		typealias OnSuccessLoginCompletion = (_ accessToken: String, _ expiresIn: Int) -> Void
		
		func login(email: String, password: String,
				   onComplete: @escaping () -> Void,
				   onSuccess: @escaping OnSuccessLoginCompletion,
				   onError: @escaping OnErrorCompletion) {
			request = provider.request(.login(email: email, password: password)) { result in
				onComplete()
				Auth.handleLoginResult(result, onSuccess: onSuccess, onError: onError)
			}
		}
		
		private static func handleLoginResult(_ result: Result<Response, MoyaError>,
									   onSuccess: OnSuccessLoginCompletion,
									   onError: OnErrorCompletion) {
			switch result {
			case let .success(moyaResponse):
				do {
					let jsonAny = try moyaResponse.mapJSON()
					
					if moyaResponse.statusCode == 401,
						let json = jsonAny as? JSON,
						let errorText = json["error"] as? String {
						onError(errorText)
						return
					}
					
					if let json = jsonAny as? JSON {
						if let errorText = json["error"] as? String {
							onError(errorText)
						} else if let token = json["access_token"] as? String,
							let expiresIn = json["expires_in"] as? Int {
							onSuccess(token, expiresIn)
						}
					}
				} catch {
					onError(error.localizedDescription)
				}
			case let .failure(error):
				print(error)
				onError(error.localizedDescription)
			}
		}
		
		// resetPassword
		func resetPassword(email: String,
						   onComplete: @escaping () -> Void,
						   onSuccess: @escaping () -> Void,
						   onError: @escaping OnErrorCompletion) {
			request = provider.request(.resetPassword(email: email)) { result in
				onComplete()
				BaseApi.handleResult(result, onSuccess: { json in
					if let error = json["errors"] as? String {
						onError(error)
					} else {
						onSuccess()
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
