//
//  PushNotification.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

struct PushNotification: Decodable {
	let text: String
	var date: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		return dateFormatter.date(from: _date)!
	}
	private let _date: String
	
	enum CodingKeys: String, CodingKey {
		case text
		case _date = "updated_at"
	}
}
