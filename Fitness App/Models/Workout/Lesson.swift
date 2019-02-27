//
//  Lesson.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Lesson: Decodable {
	let id: Int
	let title: String
	private let _date: String
	let photo: String?
	let video: String?
	let week: Int
	let text: String
	let digit: String
	private let _exercisesCount: Int
	
	var isNews: Bool {
		return _exercisesCount == 0
	}
	
	var date: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		return dateFormatter.date(from: _date)!
	}
	
	enum CodingKeys: String, CodingKey {
		case title, photo, video, week, text, id
		case digit = "unique_digit"
		case _date = "created_at"
		case _exercisesCount = "training_items_count"
	}
}
