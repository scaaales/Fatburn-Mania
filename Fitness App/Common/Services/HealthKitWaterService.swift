//
//  HealthKitWaterService.swift
//  Fitness App
//
//  Created by scales on 2/20/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import HealthKit

enum HealthKitWaterService {
	static func addWaterInOunces(_ value: Double, on date: Date, successCompletion: @escaping () -> Void) {
		addWater(value, in: .fluidOunceUS(), on: date, successCompletion: successCompletion)
	}
	
	static func addWaterInPints(_ value: Double, on date: Date, successCompletion: @escaping () -> Void) {
		addWater(value, in: .pintUS(), on: date, successCompletion: successCompletion)
	}
	
	private static func addWater(_ value: Double, in unit: HKUnit, on date: Date, successCompletion: @escaping () -> Void) {
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater),
			let correlationType = HKObjectType.correlationType(forIdentifier: .food) else {
			fatalError("Water Type is no longer available in HealthKit")
		}
		
		let quantityAmount = HKQuantity(unit: unit, doubleValue: value)
		
		let waterSample = HKQuantitySample(type: quantityType, quantity: quantityAmount, start: date, end: date)
		
		let waterCorrelationForWaterAmount = HKCorrelation(type: correlationType, start: date, end: date, objects: [waterSample])
		
		HealthKitService.healthStore.save(waterCorrelationForWaterAmount) { success, error in
			if success {
				DispatchQueue.main.async {
					successCompletion()
				}
			}
			if let error = error {
				print("error = ", error)
			}
		}
	}
	
	static func deleteWaterOn(date: Date, successCompletion: @escaping () -> Void) {
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
			return
		}
		
		let predicate = HKSampleQuery.predicateForSamples(withStart: date.startOfDay, end: date.endOfDay, options: [])
		
		HealthKitService.healthStore.deleteObjects(of: quantityType, predicate: predicate) { success, _, error in
			if success {
				DispatchQueue.main.async {
					successCompletion()
				}
			}
			if let error = error {
				print("error = ", error)
			}
		}
	}
}
