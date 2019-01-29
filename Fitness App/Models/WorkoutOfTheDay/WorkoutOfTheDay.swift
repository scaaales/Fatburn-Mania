//
//  WorkoutOfTheDay.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct WorkoutOfTheDay {
	let name: String
	var duration: TimeInterval { return exercises.totalDuration }
	let rewardCoins: Int
	let desritpion: String
	let previewImage: UIImage
	let sponsorImage: UIImage
	let exercises: [Exercise]
}
