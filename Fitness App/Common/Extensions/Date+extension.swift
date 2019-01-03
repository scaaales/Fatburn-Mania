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
		let dateFortammet = DateFormatter()
		
		dateFortammet.dateFormat = "dd.MM.yyyy HH:mm"
		
		return dateFortammet.string(from: Date())
	}
}

