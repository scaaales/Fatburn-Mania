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
		// TODO: some formatting shit to get timeinterval from string
		return 20
	}
	
	enum CodingKeys: String, CodingKey {
		case photo, title, video
		case isBreak = "is_break"
		case _duration = "duration"
	}
}
