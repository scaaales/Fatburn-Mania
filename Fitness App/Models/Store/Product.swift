//
//  Product.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Product: Decodable {
	let id: Int
	let title: String
	let description: String
	let shortDescription: String
	let price: Int
	let photoUrlString: String
	
	enum CodingKeys: String, CodingKey {
		case photoUrlString = "photo"
		case shortDescription = "short_description"
		case id, title, description, price
	}
}
