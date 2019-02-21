//
//  Measurements.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

struct Measurements {
	let chest: Int
	let waist: Int
	let thighs: Int
	let hip: Int
	let weight: Double
	let dateString: String?
}

extension Measurements: Codable {
	var date: Date? {
		guard let dateString = dateString else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		return dateFormatter.date(from: dateString)!
	}
	
	enum CodingKeys: String, CodingKey {
		case chest, waist, thighs, weight
		case dateString = "created_at"
		case hip = "hips"
	}
}
