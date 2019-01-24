//
//  Exercise.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Exercise {
	let image: UIImage
	let name: String
	let duration: String
	
	static var testExercises: [Exercise] {
		return [
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: #imageLiteral(resourceName: "break"), name: "Отдых", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: #imageLiteral(resourceName: "break"), name: "Отдых", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30"),
			.init(image: .init(), name: "Джампинг джек", duration: "00:30")
		]
	}
}
