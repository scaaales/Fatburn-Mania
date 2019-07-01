//
//  Date+extension.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import Foundation

extension Date {
	var startOfDay: Date {
		return Calendar.current.startOfDay(for: self)
	}
	
	var endOfDay: Date {
		var components = DateComponents()
		components.day = 1
		components.second = -1
		return Calendar.current.date(byAdding: components, to: startOfDay)!
	}
	
	var timeAgoDisplay: String {
		let calendar = Calendar.current
		let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
		let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
		let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
		let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
		
		if minuteAgo < self {
			let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
			return "\(diff) seconds ago"
		} else if hourAgo < self {
			let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
			return "\(diff) minunes ago"
		} else if dayAgo < self {
			let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
			return "\(diff) hours ago"
		} else if weekAgo < self {
			let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
			return "\(diff) days ago"
		}
		let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
		return "\(diff) weeks ago"
	}
	
	var formattedStringWithTime: String {
		let dateFormattet = DateFormatter()
		
		dateFormattet.dateFormat = "dd.MM.yyyy HH:mm"
		
		return dateFormattet.string(from: self)
	}
	
	var formattedStringWithBlankTime: String {
		let dateFormattet = DateFormatter()
		
		dateFormattet.dateFormat = "dd.MM.yyyy --:--"
		
		return dateFormattet.string(from: self)
	}
	
	var month: Int {
		return Calendar.current.component(.month, from: self)
	}
	
	init(day: Int, month: Int, year: Int) {
		let calendar = Calendar.current
		let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
		self = dateComponents.date!
	}
}

