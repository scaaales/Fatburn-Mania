//
//  TrainingDay.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import Foundation

struct TrainingDay: Decodable {
	let duration: String?
	let calories: Int?
	let coins: Int?
	
	init() {
		self.duration = nil
		self.calories = nil
		self.coins = nil
	}
}
