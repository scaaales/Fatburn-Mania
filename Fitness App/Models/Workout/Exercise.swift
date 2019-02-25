//
//  Exercise.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Exercise: Decodable {
	let image: String
	let name: String
	let duration: TimeInterval
}
