//
//  FitnessAPI.swift
//  Fitness App
//
//  Created by scales on 2/6/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya
import KeychainSwift
import Result

typealias JSON = [String: Any]

enum FitnessApi {
	enum Auth {
		static private let provider = MoyaProvider<AuthService>(plugins: [NetworkActivityPlugin.default])
		
		typealias OnErrorCompletion = (_ errorMessage: String) -> Void
		
		// register
		typealias OnSuccessRegisterCompletion = (_ message: String) -> Void
		
		static func registerUserWith(name: String,
									 phone: String,
									 email: String,
									 password: String,
									 onComplete: @escaping () -> Void,
									 onSuccess: @escaping OnSuccessRegisterCompletion,
									 onError: @escaping OnErrorCompletion) {
			provider.request(.register(name: name,
									   phone: phone,
									   email: email,
									   password: password)) { result in
										onComplete()
										handleResult(result,
													 onSuccess: { json in
														handleRegisterJSON(json, onSuccess: onSuccess, onError: onError)
										}, onError: { error in
											onError(error)
										})
			}
			
		}
		
		private static func handleRegisterJSON(_ json: JSON,
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
		
		static func login(email: String,
						  password: String,
						  onComplete: @escaping () -> Void,
						  onSuccess: @escaping OnSuccessLoginCompletion,
						  onError: @escaping OnErrorCompletion) {
			provider.request(.login(email: email, password: password)) { result in
				onComplete()
				handleResult(result,
							 onSuccess: { json in
								if let errorText = json["error"] as? String {
									onError(errorText)
								} else if let token = json["access_token"] as? String,
									let expiresIn = json["expires_in"] as? Int {
									onSuccess(token, expiresIn)
								}
				}, onError: { error in
					onError(error)
				})
			}
		}
		
		// logout
		static func logout(token: String,
						   onComplete: @escaping () -> Void,
						   onError: @escaping OnErrorCompletion) {
			provider.request(.logout(token: token)) { result in
				handleResult(result, onSuccess: { _ in
					onComplete()
				}, onError: { error in
					onError(error)
				})
			}
		}
						   
		
		static private func handleResult(_ result: Result<Response, MoyaError>,
											 onSuccess: (JSON) -> Void,
											 onError: OnErrorCompletion) {
			switch result {
			case let .success(moyaResponse):
				if let jsonAny = try? moyaResponse.mapJSON(),
					let json = jsonAny as? JSON {
					onSuccess(json)
				}
			case let .failure(error):
				print(error)
				onError(error.localizedDescription)
			}
		}
	}
	
}
