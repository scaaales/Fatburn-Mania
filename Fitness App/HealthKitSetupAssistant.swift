//
//  HealthKitSetupAssistant.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import HealthKit

class HealthKitSetupAssistant {
	
	private enum HealthkitSetupError: Error {
		case notAvailableOnDevice
		case dataTypeNotAvailable
	}
	
	class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
		guard HKHealthStore.isHealthDataAvailable() else {
			completion(false, HealthkitSetupError.notAvailableOnDevice)
			return
		}
		
		if #available(iOS 11.0, *) {
			guard
				let steps = HKObjectType.quantityType(forIdentifier: .stepCount),
				let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
				let calories = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed),
				let proteins = HKObjectType.quantityType(forIdentifier: .dietaryProtein),
				let fats = HKObjectType.quantityType(forIdentifier: .dietaryFatTotal),
				let carbonites = HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates),
				let waist = HKObjectType.quantityType(forIdentifier: .waistCircumference) else {
					completion(false, HealthkitSetupError.dataTypeNotAvailable)
					return
			}
			
			let healthKitTypesToWrite: Set<HKSampleType> = [water]
			
			let healthKitTypesToRead: Set<HKObjectType> = [steps,
														   water,
														   calories,
														   proteins,
														   fats,
														   carbonites,
														   waist]
			HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { success, error in
				completion(success, error)
			}
			
		} else {
			completion(false, HealthkitSetupError.dataTypeNotAvailable)
			return
		}
	}
}
