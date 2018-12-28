//
//  Date+extension.swift
//  Fitness App
//
//  Created by scales on 12/27/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation
import UIKit

extension Date {
	static var todayWithCurrentTime: String {
		let dateFortammet = DateFormatter()
		
		dateFortammet.dateFormat = "dd.MM.yyyy HH:mm"
		
		return dateFortammet.string(from: Date())
	}
}

extension NSLayoutConstraint {
	
	override open var description: String {
		let id = identifier ?? ""
		return "id: \(id), constant: \(constant)"
	}
}

