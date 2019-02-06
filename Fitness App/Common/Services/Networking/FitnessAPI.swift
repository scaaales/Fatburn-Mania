//
//  FitnessAPI.swift
//  Fitness App
//
//  Created by scales on 2/6/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

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
										switch result {
										case let .success(moyaResponse):
											if let jsonAny = try? moyaResponse.mapJSON(),
												let json = jsonAny as? JSON {
												handleRegisterJSON(json, onSuccess: onSuccess, onError: onError)
											}
										case let .failure(error):
											onError(error.localizedDescription)
										}
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
				switch result {
				case let .success(moyaResponse):
					if let jsonAny = try? moyaResponse.mapJSON(),
						let json = jsonAny as? JSON {
						if let errorText = json["error"] as? String {
							onError(errorText)
						} else if let token = json["access_token"] as? String,
							let expiresIn = json["expires_in"] as? Int {
							onSuccess(token, expiresIn)
						}
					}
				case let .failure(error):
					onError(error.localizedDescription)
				}
			}
		}
	}
	
}
