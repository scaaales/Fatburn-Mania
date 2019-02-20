//
//  Measurement.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import Foundation

struct Measurement {
	var name: String
	var firstValue: Double?
	var secondValue: Double?
	var unit: String
	
	var progress: Float? {
		if let firstValue = firstValue,
			let secondValue = secondValue {
			return Float(firstValue)/Float(secondValue)
		} else {
			return nil
		}
	}
}
