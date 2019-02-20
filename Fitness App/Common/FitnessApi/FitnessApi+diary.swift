//
//  FitnessApi+diary.swift
//  Fitness App
//
//  Created by scales on 2/19/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Diary: BaseTokenApi {
		private let provider = MoyaProvider<DiaryService>(plugins: [NetworkActivityPlugin.default])
		
		private struct MeasurementsResponse: Decodable {
			let measurements: [Measurements]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case measurements = "user_measures"
				case success
			}
		}
		
		func getMeasurements(at date: Date?, limit: Int?, offset: Int? = nil,
							 onComplete: @escaping () -> Void,
							 onSuccess: @escaping ([Measurements]) -> Void,
							 onError: @escaping OnErrorCompletion) {
			var dateString: String?
			if let date = date {
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				dateString = dateFormatter.string(from: date)
			}
			request = provider.request(.getMeasurements(token: token, date: dateString,
														limit: limit, offset: offset),
									   completion: { result in
										onComplete()
										BaseApi.mapResult(result, intoItemOfType: MeasurementsResponse.self, onSuccess: { measurementsResponse in
											onSuccess(measurementsResponse.measurements)
										}, onError: onError)
			})
		}
		
		func addMeasureemts(_ measurements: Measurements,
							onComplete: @escaping () -> Void,
							onSuccess: @escaping () -> Void,
							onError: @escaping OnErrorCompletion) {
			request = provider.request(.addMeasurements(token: token, measurements: measurements),
									   completion: { result in
										onComplete()
										BaseApi.handleResult(result, onSuccess: { json in
											print(json)
										}, onError: onError)
			})
		}
	}
}
