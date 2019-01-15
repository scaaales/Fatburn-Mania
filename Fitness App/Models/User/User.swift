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
	
	var nickname: String
	var gender: Gender
	
	var dateOfBirth: Date
	var age: Int {
		let nowDate = Date()
		let calendar = Calendar.current
		
		let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: nowDate)
		return ageComponents.year!
	}
	var dateOfBirthFormatted: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM yyyy"
		
		return formatter.string(from: dateOfBirth)
	}
	
	var email: String
	var phoneNumber: String
	var avatar: UIImage
	var instagramName: String
	
	var country: String
	var city: String
	var location: String {
		return "\(city), \(country)"
	}
	let balance: UInt
}
