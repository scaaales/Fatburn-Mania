//
//  User.swift
//  Fitness App
//
//  Created by scales on 1/9/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct User: Codable {
	var firstName: String
	var lastName: String?
	
	var nickname: String?
	private var _gender: Int?
	
	private var _dateOfBirth: String?
	
	var email: String?
	var phone: String
	var instagram: String?
	
	var avatar: String?
	
	var country: String?
	var city: String?
	
	var coins: Int?
	
	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case _gender = "gender"
		case _dateOfBirth = "date_of_birth"
		
		case nickname, email, phone, instagram, avatar, country, city, coins
	}
	
	mutating func setDateOfBirth(from date: Date?) {
		if let dateOfBirth = date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			self._dateOfBirth = dateFormatter.string(from: dateOfBirth)
		} else {
			self._dateOfBirth = nil
		}
	}
	
	mutating func setGender(_ gender: Gender) {
		_gender = gender.intValue
	}
}

extension User {
	enum Gender: String {
		case male = "Male"
		case female = "Female"
		
		init?(int: Int) {
			if int == 0 {
				self = .male
			} else if int == 1 {
				self = .female
			} else {
				return nil
			}
		}
		
		var intValue: Int {
			if self == .male {
				return 0
			} else {
				return 1
			}
		}
	}
	
	var fullName: String {
		if let lastName = lastName {
			return "\(firstName) \(lastName)"
		} else {
			return firstName
		}
	}
	
	var dateOfBirth: Date? {
		guard let dateOfBirth = _dateOfBirth else { return nil }
		
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		
		return formatter.date(from: dateOfBirth)
	}
	
	var age: Int? {
		guard let dateOfBirth = dateOfBirth else { return nil }
		
		let nowDate = Date()
		let calendar = Calendar.current
		
		let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: nowDate)
		return ageComponents.year!
	}
	var dateOfBirthFormatted: String? {
		guard let dateOfBirth = dateOfBirth else { return nil }
		
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMMM yyyy"
		
		return formatter.string(from: dateOfBirth)
	}
	
	var gender: Gender? {
		if let genderInt = _gender {
			return Gender.init(int: genderInt)
		}
		return nil
	}
	
	var location: String? {
		var result: String?
		if let city = city {
			result = city
		}
		
		if let country = country {
			if result == nil {
				result = country
			} else {
				result = "\(result!), \(country)"
			}
		}
		return result
	}
	
}
