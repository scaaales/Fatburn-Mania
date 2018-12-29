//
//  HealthKitService.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import HealthKit

class HealthKitService {
	
	private enum HealthkitSetupError: Error {
		case notAvailableOnDevice
		case dataTypeNotAvailable
	}
	
	private static let healthStore = HKHealthStore()
	
	// MARK: - Authorization
	class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
		guard HKHealthStore.isHealthDataAvailable() else {
			completion(false, HealthkitSetupError.notAvailableOnDevice)
			return
		}
		
		guard
			let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
			let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
			let calories = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed),
			let proteins = HKObjectType.quantityType(forIdentifier: .dietaryProtein),
			let fats = HKObjectType.quantityType(forIdentifier: .dietaryFatTotal),
			let carbonites = HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates) else {
				completion(false, HealthkitSetupError.dataTypeNotAvailable)
				return
		}
		
		let healthKitTypesToWrite: Set<HKSampleType> = [water]
		
		let healthKitTypesToRead: Set<HKObjectType> = [steps,
													   water,
													   calories,
													   proteins,
													   fats,
													   carbonites]
		HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
			completion(success, error)
		}
		
		
	}
	
	class func getSteps(on date: Date, completion: @escaping (Steps?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .stepCount,
							date: date) { result in
			if let result = result {
				let steps = Steps(current: Int(result), goal: 8000)
				completion(steps)
			} else {
				completion(nil)
			}
		}
	}
	
	class func getWater(on date: Date, completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryWater,
							date: date,
							unit: HKUnit.pintUS()) { result in
								if let result = result {
									let firstValue = Int(result)
									let water = Measurement(name: "", firstValue: firstValue, secondValue: 2, unit: "pt")
									completion(water)
								} else {
									completion(nil)
								}
		}
	}
	
	class func getCalories(on date: Date, completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryEnergyConsumed,
							date: date,
							unit: .kilocalorie()) { result in
								if let result = result {
									let currentValue = Int(result)
									let calories = Measurement(name: "Calories", firstValue: currentValue, secondValue: 1980, unit: "kcal")
									completion(calories)
								} else {
									completion(nil)
								}
		}
	}
	
	class func getProteins(on date: Date, completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryProtein,
							date: date,
							unit: .gram()) { result in
								if let result = result {
									let currentValue = Int(result)
									let proteins = Measurement(name: "Proteins", firstValue: currentValue, secondValue: 500, unit: "oz")
									completion(proteins)
								} else {
									completion(nil)
								}
		}
	}
	
	class func getFats(on date: Date, completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryFatTotal,
							date: date,
							unit: .gram()) { result in
								if let result = result {
									let currentValue = Int(result)
									let fats = Measurement(name: "Fats", firstValue: currentValue, secondValue: 500, unit: "oz")
									completion(fats)
								} else {
									completion(nil)
								}
		}
	}
	
	class func getCarbohydrates(on date: Date, completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryCarbohydrates,
							date: date,
							unit: .gram()) { result in
								if let result = result {
									let currentValue = Int(result)
									let carbohydrates = Measurement(name: "Carbohydrates", firstValue: currentValue, secondValue: 500, unit: "oz")
									completion(carbohydrates)
								} else {
									completion(nil)
								}
		}
	}
}

private extension HealthKitService {
	class func getPropertyValueFor(quantityIdentifier: HKQuantityTypeIdentifier,
										   options: HKStatisticsOptions = .cumulativeSum,
										   date: Date,
										   unit: HKUnit = .count(),
										   completion: @escaping (Double?) -> Void) {
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: quantityIdentifier) else {
			completion(nil)
			return
		}
		
		let predicate = HKQuery.predicateForSamples(withStart: date.startOfDay,
													end: date.endOfDay,
													options: .strictStartDate)
		
		let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: options) { _, result, error in
			if let error = error {
				fatalError(error.localizedDescription)
			}
			guard let result = result, let sum = result.sumQuantity() else {
				completion(nil)
				return
			}
			let resultValue = sum.doubleValue(for: unit)
			completion(resultValue)
		}
		
		healthStore.execute(query)
	}
}
