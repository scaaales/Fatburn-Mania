//
//  CoinsHistory.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

struct CoinsHistory: Decodable {
	let type: String
	let numberOfCoins: Int
	private let _date: String
	
	enum CodingKeys: String, CodingKey {
		case type = "type_title"
		case numberOfCoins = "value"
		case _date = "created_at"
	}
}

extension CoinsHistory {
	var date: Date {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(abbreviation: "UTC")
		
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		return formatter.date(from: _date)!
	}
}
