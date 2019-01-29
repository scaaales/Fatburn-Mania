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
	
	static var todayWithCurrentTime: String {
		let dateFormattet = DateFormatter()
		
		dateFormattet.dateFormat = "dd.MM.yyyy HH:mm"
		
		return dateFormattet.string(from: Date())
	}
	
	var month: Int {
		return Calendar.current.component(.month, from: self)
	}
	
//	/// Get date object from string
//	///
//	/// - Parameter string: date string in format yyyy MM dd (example 2017 12 01)
//	/// - Returns: Date object
//	static func getDate(from string: String) -> Date {
//		let formatter = DateFormatter()
//
//		formatter.dateFormat = "yyyy MM dd"
//		formatter.timeZone = Calendar.current.timeZone
//
//		if let date = formatter.date(from: string) {
//			return date
//		} else {
//			fatalError()
//		}
//	}
	
	init(day: Int, month: Int, year: Int) {
		let calendar = Calendar.current
		let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
		self = dateComponents.date!
	}
}

