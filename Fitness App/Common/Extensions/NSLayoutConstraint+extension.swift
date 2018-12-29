//
//  NSLayoutConstraint+extension.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
	
	override open var description: String {
		let id = identifier ?? ""
		return "id: \(id), constant: \(constant)"
	}
}
