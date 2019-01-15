//
//  User.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct User {
	enum Gender: String {
		case male = "Male"
		case femele = "Female"
	}
	
	var firstName: String
	var lastName: String
	var fullName: String {
		return "\(firstName) \(lastName)"
	}
	var gender: Gender
	var dateOfBirth: Date
	var age: Int {
		let nowDate = Date()
		let calendar = Calendar.current
		
		let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: nowDate)
		return ageComponents.year!
	}
	var email: String
	var phoneNumber: String
	var avatar: UIImage
	var instagramName: String
	var location: String
	let balance: UInt
}
