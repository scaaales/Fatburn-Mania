//
//  TrainingDayCell.swift
//  Fitness App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class TrainingDayCell: UITableViewCell, ConfigurableCell {
	typealias DataType = TrainingDay
	
	@IBOutlet private weak var timeLabel: UILabel!
	@IBOutlet private weak var caloriesLabel: UILabel!
	@IBOutlet private weak var coinsLabel: UILabel!
	
	func configure(data: TrainingDay) {
		timeLabel.text = data.duration ?? "--:--"
		
		if let calories = data.calories {
			caloriesLabel.text = "\(calories)"
		} else {
			caloriesLabel.text = "--"
		}
		
		if let coins = data.coins {
			coinsLabel.text = "\(coins)"
		} else {
			coinsLabel.text = "--"
		}
	}
}
