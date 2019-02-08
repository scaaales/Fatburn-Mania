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
	class Auth {
		private let provider = MoyaProvider<AuthService>(plugins: [NetworkActivityPlugin.default])
		
		private var request: Cancellable?
		
		typealias OnErrorCompletion = (_ errorMessage: String) -> Void
		
		// register
		typealias OnSuccessRegisterCompletion = (_ message: String) -> Void
		
		func registerUserWith(name: String,
									 phone: String,
									 email: String,
									 password: String,
									 onComplete: @escaping () -> Void,
									 onSuccess: @escaping OnSuccessRegisterCompletion,
									 onError: @escaping OnErrorCompletion) {
			request = provider.request(.register(name: name,
											  phone: phone,
											  email: email,
											  password: password)) { result in
												onComplete()
												self.handleResult(result,
															 onSuccess: { json in
																self.handleRegisterJSON(json, onSuccess: onSuccess, onError: onError)
												}, onError: { error in
													onError(error)
												})
			}
			
		}
		
		func handleRegisterJSON(_ json: JSON,
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
		
		func login(email: String,
						  password: String,
						  onComplete: @escaping () -> Void,
						  onSuccess: @escaping OnSuccessLoginCompletion,
						  onError: @escaping OnErrorCompletion) {
			request = provider.request(.login(email: email, password: password)) { result in
				onComplete()
				self.handleResult(result,
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
		func logout(token: String,
						   onComplete: @escaping () -> Void,
						   onSuccess: @escaping () -> Void,
						   onError: @escaping OnErrorCompletion) {
			request = provider.request(.logout(token: token)) { result in
				onComplete()
				self.handleResult(result, onSuccess: { _ in
					onSuccess()
				}, onError: { error in
					onError(error)
				})
			}
		}
		
		
		private func handleResult(_ result: Result<Response, MoyaError>,
										 onSuccess: (JSON) -> Void,
										 onError: OnErrorCompletion) {
			switch result {
			case let .success(moyaResponse):
				do {
					_ = try moyaResponse.filterSuccessfulStatusCodes()
					let jsonAny = try moyaResponse.mapJSON()
					
					if let json = jsonAny as? JSON {
						onSuccess(json)
					}
				} catch {
					onError(error.localizedDescription)
				}
			case let .failure(error):
				print(error)
				onError(error.localizedDescription)
			}
		}
		
		deinit {
			request?.cancel()
		}
	}
	
}
