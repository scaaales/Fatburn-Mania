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
	
	let name: String
	let gender: Gender
	let age: UInt8
	let email: String
	let phoneNumber: String
	let avatar: UIImage
	let instagramName: String
	let location: String
	let balance: UInt
}
