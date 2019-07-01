//
//  WorkoutOfTheDay.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct WorkoutOfTheDay: Decodable {
	let title: String
	var duration: TimeInterval { return exercises.totalDuration }
	let reward: Int
	let text: String
	let photo: String
	let exercises: [Exercise]
	
	enum CodingKeys: String, CodingKey {
		case exercises = "training_items"
		case title, reward, text, photo
	}
}
