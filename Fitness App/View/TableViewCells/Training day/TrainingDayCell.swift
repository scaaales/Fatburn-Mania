//
//  TrainingDayCell.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class TrainingDayCell: UITableViewCell, ConfigurableCell {
	typealias DataType = TrainingDay
	
	@IBOutlet private weak var timeLabel: UILabel!
	@IBOutlet private weak var caloriesLabel: UILabel!
	@IBOutlet private weak var coinsLabel: UILabel!
	
	func configure(data: TrainingDay) {
		timeLabel.text = data.time
		caloriesLabel.text = data.calories
		coinsLabel.text = data.coins
	}
}
