//
//  FitnessApi.swift
//  Fitness App
//
//  Created by scales on 2/6/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya
import Result

typealias JSON = [String: Any]

enum FitnessApi {
	typealias OnErrorCompletion = (_ errorMessage: String) -> Void
	
	static func handleResult(_ result: Result<Response, MoyaError>,
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
	
	static func mapResult<T: Decodable>(_ result: Result<Response, MoyaError>,
										intoItemOfType: T.Type,
										onSuccess: (T) -> Void,
										onError: OnErrorCompletion) {
		switch result {
		case let .success(moyaResponse):
			do {
				_ = try moyaResponse.filterSuccessfulStatusCodes()
				let data = moyaResponse.data
				
//				print(try moyaResponse.mapJSON())
				let jsonDecoder = JSONDecoder()
				
				let result = try jsonDecoder.decode(T.self, from: data)
				onSuccess(result)
			} catch {
				print(error)
				onError(error.localizedDescription)
			}
		case let .failure(error):
			print(error)
			onError(error.localizedDescription)
		}
	}
}

