//
//  ExerciseCell.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell, ConfigurableCell {
	typealias DataType = Exercise
	
	@IBOutlet private weak var exerciseImageView: UIImageView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var durationLabel: UILabel!
	
	func configure(data: Exercise) {
		exerciseImageView.image = data.image
		nameLabel.text = data.name
		durationLabel.text = data.duration.stringFromTimeInterval
	}

}
