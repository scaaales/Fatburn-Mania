//
//  Exercise.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Exercise: Decodable {
	let photo: String?
	let title: String
	private let _duration: String
	let video: String?
	let isBreak: Bool
	
	var duration: TimeInterval {
		guard !_duration.isEmpty else {
			return 0
		}
		
		var interval:Double = 0
		
		let parts = _duration.components(separatedBy: ":")
		for (index, part) in parts.reversed().enumerated() {
			interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
		}
		
		return interval
	}
	
	enum CodingKeys: String, CodingKey {
		case photo, title, video
		case isBreak = "is_break"
		case _duration = "duration"
	}
}
