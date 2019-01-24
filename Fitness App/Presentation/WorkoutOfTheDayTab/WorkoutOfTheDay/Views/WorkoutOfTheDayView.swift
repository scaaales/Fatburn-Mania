//
//  WorkoutOfTheDayView.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol WorkoutOfTheDayView: View, TableViewUpdatable {
	func setLessonName(_ name: String,
					   reward: Int,
					   duration: Int,
					   description: String)
	func setLessonSponsorImage(_ sponsorImage: UIImage,
							   previewImage: UIImage)
}
