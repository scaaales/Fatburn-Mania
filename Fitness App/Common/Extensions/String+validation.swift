//
//  String+validation.swift
//  Fitness App
//
//  Created by scales on 2/6/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

extension String {
	func isValidEmail() -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}
}
