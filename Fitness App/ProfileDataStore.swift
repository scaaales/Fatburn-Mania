//
//  ProfileDataStore.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import HealthKit

class ProfileDataStore {
	
	private static let healthStore = HKHealthStore()
	
	class func getTodaySteps(completion: @escaping (Steps?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .stepCount) { result in
			if let result = result {
				let steps = Steps(current: Int(result), goal: 8000)
				completion(steps)
			} else {
				completion(nil)
			}
		}
	}
	
	private class func getPropertyValueFor(quantityIdentifier: HKQuantityTypeIdentifier,
										   options: HKStatisticsOptions = .cumulativeSum,
										   unit: HKUnit = .count(),
										   completion: @escaping (Double?) -> Void) {
		guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: quantityIdentifier) else {
			completion(nil)
			return
		}
		
		let now = Date()
		let startOfDay = Calendar.current.startOfDay(for: now)
		let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
		
		let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: options) { _, result, error in
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
	
	class func getTodayWater(completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryWater,
							unit: .literUnit(with: .milli)) { result in
			if let result = result {
				let firstValue = Int(result)
				let water = Measurement.init(name: "", firstValue: firstValue, secondValue: 2000, unit: "ml")
				completion(water)
			} else {
				completion(nil)
			}
		}
	}
	
	class func getTodayCalories(completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryEnergyConsumed,
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
	
	class func getTodayProteins(completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryProtein,
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
	
	class func getTodayFats(completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryFatTotal,
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
	
	class func getTodayCarbohydrates(completion: @escaping (Measurement?) -> Void) {
		getPropertyValueFor(quantityIdentifier: .dietaryCarbohydrates,
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
