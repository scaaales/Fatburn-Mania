//
//  Workout.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct Workout {
	let title: String
	let date: Date
	let image: UIImage; #warning("change to type or something later")
	let season: Int
	let description: String
	let exercises: [Exercise]
	let videoID: String
}
