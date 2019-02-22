//
//  WorkoutCell.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Workout
	
	@IBOutlet private weak var lessonTitleLabel: UILabel!
	@IBOutlet private weak var lessonDateLabel: UILabel!
	@IBOutlet private weak var lessonImage: UIImageView!
	
	func configure(data: Workout) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMMM"
		
		lessonTitleLabel.text = data.title
		lessonDateLabel.text = dateFormatter.string(from: data.date).lowercased()
		lessonImage.image = data.image
	}
}
