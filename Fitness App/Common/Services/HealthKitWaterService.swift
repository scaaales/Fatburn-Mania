//
//  HealthKitWaterService.swift
//  Fitness App
//
//  Created by scales on 2/20/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import HealthKit

class HealthKitWaterService {
	private var savedWater: [Date: [HKQuantitySample]] = [:]
	
	func addWaterInPints(_ value: Double, on date: Date, successCompletion: @escaping () -> Void) {
		addWater(value, in: .pintUS(), on: date, successCompletion: successCompletion)
	}
	
	private func addWater(_ value: Double, in unit: HKUnit, on date: Date, successCompletion: @escaping () -> Void) {
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: .dietaryWater),
			let correlationType = HKObjectType.correlationType(forIdentifier: .food) else {
			fatalError("Water Type is no longer available in HealthKit")
		}
		
		let quantityAmount = HKQuantity(unit: unit, doubleValue: value)
		
		let waterSample = HKQuantitySample(type: quantityType, quantity: quantityAmount, start: date, end: date)
		
		let waterCorrelationForWaterAmount = HKCorrelation(type: correlationType, start: date, end: date, objects: [waterSample])
		
		HealthKitService.healthStore.save(waterCorrelationForWaterAmount) { [weak self] success, error in
			guard let self = self else { return }
			print("success = ", success)
			if success {
				if self.savedWater.keys.contains(date) {
					self.savedWater[date]?.append(waterSample)
				} else {
					self.savedWater[date] = [waterSample]
				}
				DispatchQueue.main.async {
					successCompletion()
				}
			}
			if let error = error {
				print("error = ", error)
			}
		}
	}
	
	func deleteWaterOn(date: Date, successCompletion: @escaping () -> Void) {
		if let savedWaterOnDate = savedWater[date] {
			HealthKitService.healthStore.delete(savedWaterOnDate) { [weak self] success, error in
				print("success = ", success)
				if success {
					self?.savedWater[date] = nil
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
}
