//
//  Date+extension.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation

extension Date {
	static var todayWithCurrentTime: String {
		let dateFortammet = DateFormatter()
		
		dateFortammet.dateFormat = "dd.MM.yyyy HH:mm"
		
		return dateFortammet.string(from: Date())
	}
}

